class Client < ActiveRecord::Base
	has_many :bookings

	# LISTC = []

	# Client.all.each do |c|
	# 	LISTC << c.name
	# end
end
