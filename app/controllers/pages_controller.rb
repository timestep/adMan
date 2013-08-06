class PagesController < ApplicationController
  before_filter :require_login
  
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

  def edit
    @page = Page.find(params[:id])
  end

  def create
    @page = Page.new(pages_params)
    if @page.save
      redirect_to pages_path, :notice => "Created new page!"
    else
      render :new
    end
  end

  def update
    @page = Page.find(params[:id])
    @page.update_attributes(pages_params)
    head :ok
    #   redirect_to pages_path
    # else
    #   render :index
    # end
  end

  def destroy
    @page = Page.find(params[:id])
    @page.destroy
    redirect_to pages_path
    # @pages = Page.all
    # respond_to do |format|
    #   format.js { render :layout=>false, :content_type => 'application/javascript' }
    # end
    #http://stackoverflow.com/questions/4398445/link-to-remote-true-not-updating-with-ajax
    #destroy action does not work with page is loaded in with ajax but it works on its actual edit_page_path(@page)
  end


  private

  def pages_params
    params.require(:page).permit(:name,:slug)
  end
end
