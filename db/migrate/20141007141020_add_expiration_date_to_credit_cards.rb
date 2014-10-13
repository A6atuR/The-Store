class AddExpirationDateToCreditCards < ActiveRecord::Migration
  def change
    add_column :credit_cards, :expiration_date, :date
    remove_column :credit_cards, :expiration_month
    remove_column :credit_cards, :expiration_year
  end
end
