class ClientsController < ApplicationController

	before_filter :require_login
	
  def index
    @clients = Client.all
    @clients_sorted = @clients.sort_by!{ |c| c.name.downcase }
    @clients_sorted_alpha = @clients_sorted.group_by { |c| c.name.downcase[0] }
  end

  def show
    @client = Client.find(params[:id])
  end

	def new
		@client = Client.new
	end

	def create
    binding.pry
    client_params.each do |c|
      @client = Client.new(c)
    end

		if @client.save
  		redirect_to clients_path, :notice => "Created new client~!"
  	else
  		render :new, :alert => "Nope"
  	end
	end

  def edit
    @client = Client.find(params[:id])
  end

  def update
    @client = Client.find(params[:id])
    @client.update_attributes(client_params)
    head :ok
  end

  def destroy
    @client = Client.find(params[:id])
    @client.destroy
    redirect_to clients_path
  end
  
	private

	def client_params
		params.require(:client).permit(:name)
	end
end
