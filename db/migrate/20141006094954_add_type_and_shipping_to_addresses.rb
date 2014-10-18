class AddTypeAndShippingToAddresses < ActiveRecord::Migration
  def change
    add_column :addresses, :address_type, :string, default: "billing"
    add_column :addresses, :shipping, :boolean, default: false
  end
end
