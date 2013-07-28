class Booking < ActiveRecord::Base
  belongs_to :user
  belongs_to :client
 	has_and_belongs_to_many :pages

 	def self.search_date(value)
 		result = Booking.find_by_date(value)
 		if result 
 			return result
 		else
 			return nil
 		end
 	end
end
