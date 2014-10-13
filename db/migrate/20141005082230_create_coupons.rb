class CreateCoupons < ActiveRecord::Migration
  def change
    create_table :coupons do |t|
      t.integer :code
      t.float :discount

      t.timestamps
    end
  end
end
