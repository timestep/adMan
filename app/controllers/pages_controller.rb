class PagesController < ApplicationController
  def new
    @page = Page.new
  end

  def create
    @page = Page.new
    if @page.save
      redirect_to bookings_path, :notice => "Created new page!"
    else
      render :new
    end
  end
end
