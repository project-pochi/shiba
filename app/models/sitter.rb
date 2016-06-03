class Sitter < ActiveRecord::Base
  belongs_to :user
  belongs_to :residence_type
  belongs_to :capacity_type

  validates :user_id,           presence: true
  validates :residence_type_id, presence: true
  validates :capacity_type_id,  presence: true
end
