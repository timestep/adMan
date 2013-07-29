class Booking < ActiveRecord::Base

  belongs_to :user
  belongs_to :client

 	has_and_belongs_to_many :pages

 	private

 	def self.search_date(value)
    value = DateTime.strptime(value, "%m/%d/%Y")
    beginning_of_day = value
    end_of_day = beginning_of_day + 1.day
    result = Booking.where(:date => beginning_of_day..end_of_day)

 		# result = Booking.find(:all, 
 		# 	:conditions => {:date => value})

 		if result.empty? 
 			return nil
 		else
 			return result
 		end

 	end
end
