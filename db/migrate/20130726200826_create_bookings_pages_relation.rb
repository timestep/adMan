class CreateBookingsPagesRelation < ActiveRecord::Migration
  def change
    create_table :bookings_pages do |t|
    	t.integer :booking_id
    	t.integer :page_id
    end
  end
end
