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
 	end

 	def create
 		# binding.prye
 		@booking = @user.bookings.build(bookings_params)
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
		binding.pry
		page_id = params["page_id"]
		if values.present? 
			results = Booking.search_date(values)
			if results 
				redirect_to booking_path(results.first.id) 
			else
				session[:booking_permit] = values
				redirect_to new_booking_path, :notice => "Available!"
			end
		else
			render :query, :notice => 'Enter date~!'
		end
	end

	private

	def bookings_params
		params.require(:booking).permit!
	end

	def present_user
		@user = current_user
	end

	def check_booking_permit
		permit = session[:booking_permit]
		if permit.present? 
			@booking_date = DateTime.strptime(session[:booking_permit], "%m/%d/%Y")
			session[:booking_permit] = nil
		else
			redirect_to query_bookings_path, alert: 'NOPE!'
		end	
	end
end
