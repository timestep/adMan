class PagesController < ApplicationController
  def index
    @pages = Page.all
    @pages_sorted = @pages.sort_by!{ |p| p.name.downcase }
    @pages_sorted_alpha = @pages_sorted.group_by { |p| p.name.downcase[0] }
  end

  def new
    @page = Page.new
  end

  def show
    @page = Page.find(params[:id])
  end

  def create
    @page = Page.new(pages_params)
    if @page.save
      redirect_to bookings_path, :notice => "Created new page!"
    else
      render :new
    end

  def edit
    @page = Page.find(params[:id])
  end

  end

  private

  def pages_params
    params.require(:page).permit(:name,:slug)
  end
end
