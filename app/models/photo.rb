class Photo < ApplicationRecord
  belongs_to :user, optional: true
  has_many :bookmarks, dependent: :destroy
  has_many :bookmarked_photos, through: :bookmarks
end
