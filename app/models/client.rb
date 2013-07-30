class Client < ActiveRecord::Base
	has_many :bookings

	# NAMES = []

	# Client.all.each do |c|
	# 	NAMES << c.name
	# end
	
end
