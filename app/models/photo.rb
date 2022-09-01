class Photo < ApplicationRecord
  belongs_to :user
  has_one_attached :photo
  # Bookmark gem
  acts_as_favoritable
  # Geocoding
  geocoded_by :location
  after_validation :geocode, if: :will_save_change_to_location?
end
