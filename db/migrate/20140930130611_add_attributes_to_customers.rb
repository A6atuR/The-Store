class AddAttributesToCustomers < ActiveRecord::Migration
  def change
    add_column :customers, :username, :string
    add_column :customers, :nickname, :string
    add_column :customers, :provider, :string
    add_column :customers, :url, :string
  end
end
