class BookingsController < ApplicationController

<<<<<<< HEAD
	before_filter :require_login
	before_filter :present_user
	before_filter :check_booking_permit, :only => :new

	def index
		if current_user
	    @bookings = Booking.all.reverse
	    @date = params[:month] ? Date.strptime(params[:month], "%Y-%m") : Date.today
 		else
 			redirect_to new_session_path
 		end
 	end

 	def day
		@month_name_with_date = Booking.return_month_name(params[:date])
		@weekday_name = Booking.return_weekday_name(params[:date])
 		date = params[:date].gsub('-', '/')
 		@bookings = Booking.search_day(date)
 		# if @bookings
 		# 	return @bookings
 		# else
 		# 	redirect_to bookings_path
 		# end
 	end

 	def week
 		date = params[:week]
 		date = DateTime.strptime(date, "%m-%d-%Y")
 		@bookings = Booking.by_week(date)
    @booking_by_week_day = @bookings
	    											.group_by{ |booking| booking.date.wday }
 	end

 	def new
 		@booking = Booking.new	# don't render the page if date or page_id is missing
 	end

 	def create
 		@booking = @user.bookings.build(bookings_params)
 		if @booking.client_id == nil
 			render :query, notice: "Gotta enter a client!"
 			# needs to be fixed, notice does not display
 			# if on the bookings page, user tries to book without entering a client
 		else
			page_ids      = params[:booking][:page_ids]
			@booking.date = DateTime.strptime(
				params[:booking][:date],"%m/%d/%Y"
			)

	 		@booking.pages << Page.find(page_ids)

			if @booking.save
				# actionmailer - sends email when booking is saved 		
				NewBooking.new_booking(@user,@booking).deliver
				redirect_to @booking
			else
				render :new
			end
		end
 	end

 	def edit
 		@booking = Booking.find(params[:id])
 	end
 	
 	def update
 		@booking = Booking.find(params[:id])
 		
 		if @booking.update_attributes(bookings_params)
      flash.now.notice = "Edited!" 
    	redirect_to booking_path(@booking)
=======
  before_filter :require_login
  before_filter :present_user
  before_filter :check_booking_permit, :only => :new

  def index
    if current_user
      @bookings = Booking.all.reverse
      @date = params[:month] ? Date.strptime(params[:month], "%Y-%m") : Date.today
     else
       redirect_to new_session_path
     end
   end

   def day
    @month_name_with_date = Booking.return_month_name(params[:date])
    @weekday_name = Booking.return_weekday_name(params[:date])
     date = params[:date].gsub('-', '/')
     @bookings = Booking.search_day(date)
     if @bookings
       return @bookings
     else
       redirect_to bookings_path
     end
   end

   def week
     date = params[:week]
     date = DateTime.strptime(date, "%m-%d-%Y")
     @bookings = Booking.by_week(date)
    @booking_by_week_day = @bookings
                            .group_by{ |booking| booking.date.wday }
   end

   def new
     @booking = Booking.new  # don't render the page if date or page_id is missing
   end

   def create
     @booking = @user.bookings.build(bookings_params)
     if @booking.client_id == nil
       render :query, notice: "Gotta enter a client!"
       # needs to be fixed, notice does not display
       # if on the bookings page, user tries to book without entering a client
     else
       @booking.date = DateTime.strptime(
         params[:booking][:date],"%m/%d/%Y")

       @booking.pages << Page.find(params[:booking][:page_id])

      if @booking.save
        NewBooking.new_booking(@user,@booking).deliver
        redirect_to @booking, notice: "Booked~!"
      else
        render :new
      end
    end
   end

   def edit
     @booking = Booking.find(params[:id])
   end

   def update
     @booking = Booking.find(params[:id])

     if @booking.update_attributes(bookings_params)
      flash.now.notice = "Edited!"
      redirect_to booking_path(@booking)
    else
      flash.now.alert = 'Not valid ?!'
      render :edit
    end
   end

  def show
    @booking = Booking.find(params[:id])
  end

  def query
    @page_collection = Page.all.collect {|p| [ p.name, p.id ]}
  end

  def search
    date = params["date-picker"]
    page_id = params["query"]["page_id"].last

    if page_id == 0
      flash.now.alert = "Please Pick A Page!"
      render :query
    elsif date.present? && page_id != 0
      results = Booking.search_date(date,page_id)
      if results
        redirect_to booking_path(results.first.id)
      else
        session[:booking_permit] = date
        session[:page_id] = page_id
        redirect_to new_booking_path(:date => date, :page_id => page_id), :notice => "Available!"
      end
    else
      redirect_to query_bookings_path, :notice => 'Enter date~!'
    end

  end

  private

  def bookings_params
    params.require(:booking).permit(:client_id, :product, :contract_num, :info)
  end

  def present_user
    @user = current_user
  end

  def check_booking_permit
    permit = session[:booking_permit]
    if permit.present?
      pageID = session[:page_id]
      page = Page.find_by_id(pageID)
      if page
        @page_name = page.name
        @page_id = session[:page_id]
        @booking_date = DateTime.strptime(session[:booking_permit], "%m/%d/%Y")
        session[:page_id] = nil
        session[:booking_permit] = nil
      else
        redirect_to query_bookings_path
      end
>>>>>>> davefp-indentation_fix
    else
      redirect_to query_bookings_path, alert: 'NOPE!'
    end
<<<<<<< HEAD
 	end

	def show
		@booking = Booking.find(params[:id])
	end

	def query
		@page_collection = Page.all.collect {|p| [ p.name, p.id ]}
	end

	def search
		date     = params["date-picker"]
		page_ids = params["query"]["page_ids"]
		page_ids.delete ""

		if page_ids.empty?
			flash.now.alert = "Please Pick A Page!"
			render :query
		elsif date.present? && !page_ids.empty?
			results = Booking.search_date(date,page_ids)
			if results
				# NOTE: Deal with 2 cases...
				# Case 1: results array returns ALL page ids
				# Case 2: results array returns SOME page ids
				redirect_to booking_path(results.first.id) 
			else
				session[:booking_permit] = date
				session[:page_ids]       = page_ids
				redirect_to new_booking_path(:date => date, :page_ids => page_ids), :notice => "Available!"
			end
		else
			redirect_to query_bookings_path, :notice => 'Enter date~!'
		end
	
	end

	private

	def bookings_params
		params.require(:booking).permit(:client_id, :product, :contract_num, :info)
	end

	def present_user
		@user = current_user
	end

	def check_booking_permit
		permit = session[:booking_permit]
		if permit.present?
			pageID = session[:page_ids]
			pages  = Page.where(:id => pageID)
			if pages.empty?
				redirect_to query_bookings_path
			else
				#@page_names = pages.map { |page| page.name } this is the same as (see next line)
				#@page_names = pages.map &:name
				@page_names = pages.map &:name
				@page_ids   = session[:page_ids]
				@booking_date = DateTime.strptime(session[:booking_permit], "%m/%d/%Y")
				session[:page_ids] = nil
				session[:booking_permit] = nil
			end
		else
			redirect_to query_bookings_path, alert: 'NOPE!'
		end	
	end
=======
  end
>>>>>>> davefp-indentation_fix
end
