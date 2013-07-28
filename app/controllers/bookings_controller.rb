class BookingsController < ApplicationController

	before_filter :require_login

	def index
    @bookings = Booking.all
 	end

	# def show
	# 	@search = Booking.search(params[:search])
	# end

	def search
	end
end
