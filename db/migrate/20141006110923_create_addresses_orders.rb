class CreateAddressesOrders < ActiveRecord::Migration
  def change
    create_table :addresses_orders, id: false do |t|
      t.belongs_to :address
      t.belongs_to :order
    end
  end
end
