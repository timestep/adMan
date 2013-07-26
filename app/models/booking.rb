class Booking < ActiveRecord::Base
  belongs_to :user
  belongs_to :client
 	has_and_belongs_to_many :pages
end
