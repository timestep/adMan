class ClientsController < ApplicationController

	before_filter :require_login
	
  def index
    @clients = Client.all
    @clients_sorted = @clients.sort_by!{ |c| c.name.downcase }
    @clients_sorted_alpha = @clients_sorted.group_by { |c| c.name.downcase }
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
