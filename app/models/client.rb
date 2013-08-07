class Client < ActiveRecord::Base
	has_many :bookings, :dependent => :destroy

	validates_presence_of :name, :on => :create
 	validates_uniqueness_of :name
end
