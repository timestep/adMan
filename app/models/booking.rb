class Booking < ActiveRecord::Base
  belongs_to :user
  belongs_to :client
 	has_and_belongs_to_many :pages


 	def self.search(search)
	  if search
	    find(:all, :conditions => ['name LIKE ?', "%#{search}%"])
	  else
	    find(:all)
	  end
	end
end
