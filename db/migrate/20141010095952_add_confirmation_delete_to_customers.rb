class AddConfirmationDeleteToCustomers < ActiveRecord::Migration
  def change
    add_column :customers, :confirmation_delete, :boolean, default: false
  end
end
