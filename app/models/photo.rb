class Photo < ApplicationRecord
  belongs_to :user
  has_many :bookmarks, dependent: :destroy
  has_many :bookmarked_photos, through: :bookmarks
  has_one_attached :photo
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

  def metadata
    result = Cloudinary::Api.resource("#{Rails.env}/#{self.photo.key}", exif: true)
    result['exif']
  end

  def metadata_location
    long = convert_dms_to_dd(metadata['GPSLongitude'])
    lat = convert_dms_to_dd(metadata['GPSLatitude'])
    [lat, long]
  end

  def metadata_creation_date_time
    metadata['DateTime']
  end

  private

  def convert_dms_to_dd(dms)
    deg = dms.split(", ")[0].to_i
    min = dms.split(", ")[1].to_i/(dms.split(", ")[1].split('/')[1].to_i)
    sec = dms.split(", ")[2].to_i/(dms.split(", ")[2].split('/')[1].to_i)
    deg + (min / 60.0) + (sec / 3600.0)
  end
end
