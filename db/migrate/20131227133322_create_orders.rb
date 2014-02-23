class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.float :total_price
      t.string :state
      t.datetime :completed_at
      t.string :status
      t.belongs_to :customer
      t.belongs_to :address

      t.timestamps
    end
  end
end
