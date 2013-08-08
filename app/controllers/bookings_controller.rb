class BookingsController < ApplicationController

	before_filter :require_login
	before_filter :present_user
	before_filter :check_booking_permit, :only => :new

	def index
		if current_user
	    @bookings = Booking.all.reverse
	    @date = params[:month] ? Date.strptime(params[:month], "%Y-%m") : Date.today

 		else
 			redirect_to new_session_path
 		end
 	end

 	def day
		@date_name = Booking.return_date_name(params[:date])
 		date = params[:date].gsub('-', '/')
 		@bookings = Booking.search_day(date)
 	end

 	def week
 		date = params[:week]
 		date = DateTime.strptime(date, "%m-%d-%Y")
 		@bookings = Booking.by_week(date)

 			    # @date = Date.today

	    # @booking_week_day = 
	    # 	@bookings.group_by do |booking|
	    # 		booking.date.wday
	    # 	end

	    @booking_by_week_day = @bookings
	    											.group_by{ |booking| booking.date.wday }

	    # render :text => @booking_week_day.to_yaml and return
 			# @booking_by_week_day = @booking_week_day.sort{ |x, y| x<=>y }

 	end

 	def new
 		@booking = Booking.new	# don't render the page if date or page_id is missing
 	end

 	def create
 		# binding.pry

 		@booking = @user.bookings.build(bookings_params)
 		if @booking.client_id == nil
 			render :query, notice: "Gotta enter a client!"
 			# needs to be fixed, notice does not display
 			# if on the bookings page, user tries to book without entering a client
 		else
	 		@booking.date = DateTime.strptime(
				params[:booking][:date], "%m/%d/%Y")

	 		@booking.pages << Page.find(params[:booking][:page_id]) 

			if @booking.save
				NewBooking.new_booking(@user,@booking).deliver
				redirect_to @booking, notice: "Booked~!"
			else
				render :new
			end
		end
 	end

 	def update
 	end

	def show
		@booking = Booking.find(params[:id])
	end

	def query
		@page_collection = Page.all.collect {|p| [ p.name, p.id ]}
	end

	def search
		date = params["date-picker"]
		page_id = params["query"]["page_id"].last
				
		if page_id == 0
			flash.now.alert = "Please Pick A Page!"
			render :query
		elsif date.present? && page_id != 0
			results = Booking.search_date(date,page_id)
			if results 
				redirect_to booking_path(results.first.id) 
			else
				session[:booking_permit] = date
				session[:page_id] = page_id
				redirect_to new_booking_path(:date => date, :page_id => page_id), :notice => "Available!"
			end
		else
			redirect_to query_bookings_path, :notice => 'Enter date~!'
		end
	
	end

	private

	def bookings_params
		params.require(:booking).permit(:client_id, :product, :contract_num, :info)
	end

	def present_user
		@user = current_user
	end

	def check_booking_permit
		permit = session[:booking_permit]
		if permit.present?
			pageID = session[:page_id]
			page = Page.find_by_id(pageID)
			if page
				@page_name = page.name
				@page_id = session[:page_id]
				@booking_date = DateTime.strptime(session[:booking_permit], "%m/%d/%Y")
				session[:page_id] = nil
				session[:booking_permit] = nil
			else
				redirect_to query_bookings_path
			end
		else
			redirect_to query_bookings_path, alert: 'NOPE!'
		end	
	end
end
