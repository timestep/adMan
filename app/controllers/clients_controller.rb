class ClientsController < ApplicationController

	before_filter :require_login
	
	def new
		@client = Client.new
	end

	def create
		@client = Client.new
		if @client.save
  		redirect_to bookings_path, :notice => "Created new client~!"
  	else
  		render :new
  	end
	end
end
