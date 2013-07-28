class BookingsController < ApplicationController

	before_filter :require_login

	def index
		if current_user
	    @bookings = Booking.all
 		else
 			redirect_to new_session_path
 		end
 	end

	def show

	end

	def query
		# @values = params["search"]

	end

	def search
		if values = params["search"]
			@results = Booking.search_date(values)
		else
		end


	end
end
