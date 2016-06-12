class Location < ActiveRecord::Base
  validates :zip_code, format: { with: /\A\d{3}\-\d{4}\z/ }, uniqueness: true

  geocoded_by :zip_code
  after_validation :geocode, if: :zip_code_changed?

end
