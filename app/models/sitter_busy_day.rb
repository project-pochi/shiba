class SitterBusyDay < ActiveRecord::Base
  belongs_to :sitter

  validates :sitter_id, presence: true
  validates :sunday,    presence: true
  validates :monday,    presence: true
  validates :tuesday,   presence: true
  validates :wednesday, presence: true
  validates :thursday,  presence: true
  validates :friday,    presence: true
  validates :saturday,  presence: true
end
