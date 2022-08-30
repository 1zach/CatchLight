class Photo < ApplicationRecord
  belongs_to :user
  has_many :bookmarks, dependent: :destroy
  has_many :bookmarked_photos, through: :bookmarks
  # Geocoding
  geocoded_by :location
  after_validation :geocode, if: :will_save_change_to_location?

  # Searchbar

  include PgSearch::Model
  pg_search_scope :search_by_dates_and_location,
  against: [ :creation_date_time, :location ],
  using: {
    tsearch: { prefix: true }
  }
end
