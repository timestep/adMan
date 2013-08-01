class AddingContractProductInfoColumnsToBookingsTable < ActiveRecord::Migration
  def change
    add_column :bookings, :contract_num, :string
    add_column :bookings, :product, :string
    add_column :bookings, :info, :text
  end
end
