class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :title
      t.text :description
      t.float :price
      t.integer :in_stock
      t.belongs_to :category

      t.timestamps
    end
  end
end
