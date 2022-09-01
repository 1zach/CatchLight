class Photo < ApplicationRecord
  belongs_to :user
  has_many :bookmarks, dependent: :destroy
  has_many :bookmarked_photos, through: :bookmarks
  has_one_attached :photo
  # Geocoding
  geocoded_by :location
  after_validation :geocode, if: :will_save_change_to_location?
end
