class CreateCreditCards < ActiveRecord::Migration
  def change
    create_table :credit_cards do |t|
      t.integer :number
      t.integer :cvv
      t.string :expiration_month
      t.integer :expiration_year
      t.belongs_to :customer

      t.timestamps
    end
  end
end
