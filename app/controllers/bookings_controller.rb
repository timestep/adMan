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
	end

	def search
		@values = params["search"]
		# if @values 
		# 	redirect_to bookings_path
		# else
		# 	redirect_to root_path
		# end


	end
end
