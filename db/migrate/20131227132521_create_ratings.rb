class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.integer :rating
      t.text :text
      t.belongs_to :book
      t.belongs_to :customer

      t.timestamps
    end
  end
end
