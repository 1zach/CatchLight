class AddColumnToPhotos < ActiveRecord::Migration[7.0]
  def change
    add_column :photos, :trip, :string
  end
end
