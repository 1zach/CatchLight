class CreatePhotos < ActiveRecord::Migration[7.0]
  def change
    create_table :photos do |t|
      t.text :url
      t.string :creator
      t.string :focal_length
      t.datetime :creation_date_time
      t.string :camera
      t.string :aperture
      t.string :lens
      t.string :location
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
