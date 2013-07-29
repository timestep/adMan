class BookingsController < ApplicationController

	before_filter :require_login
	before_filter :present_user

	def index
		if current_user
	    @bookings = Booking.all
 		else
 			redirect_to new_session_path
 		end
 	end

 	def new
 		@booking = @user.bookings.create
 	end

 	def create
 		@user = current_user
 		@booking = @user.bookings.build booking_params
		# @booking.user = current_user
		if @booking.save
			redirect_to @booking, notice: "Booked~!"
		else
			render :new
		end
 	end

	def show
		@booking = Booking.find(params[:id])
	end

	def query
	end

	def search
		values = params["date-picker"]

		if values.length != 0
			results = Booking.search_date(values)
			if results 
				# binding.pry
				redirect_to booking_path(results.first.id) 
			else
				redirect_to new_booking_path, :notice => "Not Available!"
			end
		else
			render :query, :notice => 'Enter date~!'
		end
	end

	private

	def bookings_params
		params.require(:bookings).permit!
	end

	def present_user
		@user = current_user
	end

end
