class Artist < ActiveRecord::Base
  has_many :songs
  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders]
end
