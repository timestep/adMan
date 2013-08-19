class Booking < ActiveRecord::Base

  belongs_to :user
  belongs_to :client

   has_and_belongs_to_many :pages

   validates_presence_of :user, :on=>:create
   validates_presence_of :client, :on=>:create
   validates_presence_of :date, :on=>:create

   private

  # Checks a day for a page
 	def self.search_date(value, page_ids=nil) 
    value = DateTime.strptime(value, "%m/%d/%Y")

    beginning_of_day = value
    end_of_day = beginning_of_day + 1.day

    result = Booking.includes(:pages)
    	.where(:date => beginning_of_day..end_of_day)
    	.where("pages.id" => page_ids)
 		if result.empty? 
 			return nil
 		else
 			return result
 		end
 	end

  # Returns all pages on a day
  def self.search_day(value) 
    value = DateTime.strptime(value, "%m/%d/%Y")

    beginning_of_day = value
    end_of_day = beginning_of_day + 1.day

    result = Booking.includes(:pages)
      .where(:date => beginning_of_day..end_of_day)
    if result.empty?
      return nil
    else
      return result
    end
  end

  def self.return_month_name(value)
    month_name = DateTime.strptime(value, "%m-%d-%Y")
    result = month_name.strftime('%b %d %Y')
    if result.empty?
      return nil
    else
      return result
    end
  end

  def self.return_weekday_name(value)
    weekday_name = DateTime.strptime(value, "%m-%d-%Y")
    result = weekday_name.strftime('%a')
    if result.empty?
      return nil
    else
      return result
    end
  end

  # Returns bookings in the week of the date provided
  def self.by_week(date)
    where("EXTRACT(WEEK FROM date) = #{date.cweek}")
  end
end
