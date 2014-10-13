class AddAttributesToCoupones < ActiveRecord::Migration
  def change
    add_column :coupons, :order_id, :integer
    add_column :coupons, :used, :boolean, default: false
  end
end
