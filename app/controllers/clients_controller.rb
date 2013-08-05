class ClientsController < ApplicationController

	before_filter :require_login
	
  def index
    @clients = Client.all
  end


	def new
		@client = Client.new
	end

	def create
		@client = Client.new(client_params)

		if @client.save
  		redirect_to bookings_path, :notice => "Created new client~!"
  	else
  		render :new, :alert => "Nope"
  	end
	end

	private

	def client_params
		params.require(:client).permit(:name)
	end
end
