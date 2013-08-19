class SessionsController < ApplicationController
  def new
  end

  def create
<<<<<<< HEAD
	  user = login(params[:email], params[:password])
	  if user
	    redirect_to bookings_path
	  else
	    flash.now.alert = "Email or password was invalid"
	    render :new
	  end
	end
=======
    user = login(params[:email], params[:password])
    if user
      redirect_to bookings_path, :notice => "Logged in~!"
    else
      flash.now.alert = "Email or password was invalid"
      render :new
    end
  end
>>>>>>> davefp-indentation_fix

  def destroy
    logout
    redirect_to root_url, :notice => "Logged out!"
  end
end
