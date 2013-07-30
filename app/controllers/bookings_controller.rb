class BookingsController < ApplicationController

	before_filter :require_login
	before_filter :present_user
	before_filter :check_booking_permit, :only => :new

	def index
		if current_user
	    @bookings = Booking.all.reverse
 		else
 			redirect_to new_session_path
 		end
 	end

 	def new
 		@booking = Booking.new

 

 		# don't render the page if date or page_id is missing
 	end

 	def create
 		@booking = @user.bookings.build(bookings_params)
		@booking.date = DateTime.strptime(params[:booking][:date], "%m/%d/%Y")
 		@booking.pages << Page.find(params[:booking][:page_id]) 
		if @booking.save

			redirect_to @booking, notice: "Booked~!"
		else
			render :new
		end
 	end

 	def update
 	end

	def show
		@booking = Booking.find(params[:id])
	end

	def query
	end

	def search
		values = params["date-picker"]
		page_id = params["query"]["page_id"].to_i
		if values.present? 
			results = Booking.search_date(values,page_id)
			if results 
				redirect_to booking_path(results.first.id) 
			else
				session[:booking_permit] = values
				session[:page_id] = page_id
				redirect_to new_booking_path(:date => values, :page_id => page_id), :notice => "Available!"

				# this is what we want, instead of using session variables
				# http://poop.com/bookings/new?date=xxxyyyy&page_id=3

				# GET request to
				# /bookings/new
				# new_bookings_path( :date => "xxxyyyy", :page_id => "3" )
				# new_bookings_path

				# PATCH a particular booking:
				# booking_path( :id => @booking.id )

				# on the controller side for bookings, you'll have an action for new:
				# in the new action...
				# params[:page_id] == 3
				# params[:date] == xxxyyyy


			end
		else
			render :query, :notice => 'Enter date~!'
		end
	end

	private

	def bookings_params
		params.require(:booking).permit(:client_id)
	end

	def present_user
		@user = current_user
	end

	def check_booking_permit
		permit = session[:booking_permit]
		if permit.present? 
			@page_name = Page.find(session[:page_id]).name
			@page_id = session[:page_id]
			@booking_date = DateTime.strptime(session[:booking_permit], "%m/%d/%Y")
			session[:page_id] = nil
			session[:booking_permit] = nil
		else
			redirect_to query_bookings_path, alert: 'NOPE!'
		end	
	end
end
