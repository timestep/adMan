class Booking < ActiveRecord::Base
  belongs_to :user
  belongs_to :client
 	has_and_belongs_to_many :pages

 	def self.search(search)
	  if search
	  	find_by_da
	  else
	    find(:all)
	  end
	end
end
