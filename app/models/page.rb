class Page < ActiveRecord::Base
	has_and_belongs_to_many :bookings

	validates_presence_of :name, :on => :create
 	validates_uniqueness_of :name
 	validates_presence_of :slug, :on => :create
 	validates_uniqueness_of :slug
end
