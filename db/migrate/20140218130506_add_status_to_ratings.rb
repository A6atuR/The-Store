class AddStatusToRatings < ActiveRecord::Migration
  def change
    add_column :ratings, :status, :string
  end
end
