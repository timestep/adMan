class BookingsController < ApplicationController

	before_filter :require_login

	def index
		if current_user
	    @bookings = Booking.all
 		else
 			redirect_to new_session_path
 		end
 	end

 	def new
 	end

 	def create
 	end

	def show
		@booking = Booking.find(params[:id])
	end

	def query
		# @values = params["search"]

	end

	def search
		if values = params["search"]
			results = Booking.search_date(values)
			if results 
				redirect_to booking_path(results.id) :alert => 'Not Available!'
			else
				redirect_to new_booking_path :notice => 'Available!'
			end
		else
			redirect_to root_path
		end
	end
end
