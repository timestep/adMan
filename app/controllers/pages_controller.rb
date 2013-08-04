class PagesController < ApplicationController
  def index
    @pages = Page.all
  end

  def new
    @page = Page.new
  end

  def create
    @page = Page.new(pages_params)
    if @page.save
      redirect_to bookings_path, :notice => "Created new page!"
    else
      render :new
    end
  end

  private

  def pages_params
    params.require(:page).permit(:name,:slug)
  end
end
