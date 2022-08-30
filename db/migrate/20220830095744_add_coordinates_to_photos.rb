class AddCoordinatesToPhotos < ActiveRecord::Migration[7.0]
  def change
    add_column :photos, :latitude, :float
    add_column :photos, :longitude, :float
  end
end
