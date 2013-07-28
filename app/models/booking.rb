class Booking < ActiveRecord::Base

  belongs_to :user
  belongs_to :client

 	has_and_belongs_to_many :pages

 	private

 	def self.search_date(value)
 		result = Booking.find(:all, 
 			:conditions => {:date => value[:date]})

 		if result.empty? 
 			return nil
 		else
 			return result
 		end

 	end
end
