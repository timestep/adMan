class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.datetime :date
      t.references :user, index: true
      t.references :client, index: true

      t.timestamps
    end
  end
end
