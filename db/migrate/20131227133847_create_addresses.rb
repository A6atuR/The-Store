class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :address
      t.string :zip_code
      t.string :city
      t.string :phone
      t.belongs_to :country

      t.timestamps
    end
  end
end
