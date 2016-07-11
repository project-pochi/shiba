class SitterBusyDate < ActiveRecord::Base
  belongs_to :sitter

  validates :sitter_id, presence: true
  validates :date,      presence: true
  validates :type,      inclusion: { in: ["busy"] }
end
