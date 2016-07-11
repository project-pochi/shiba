class SitterBusyDate < ActiveRecord::Base
  belongs_to :sitter

  validates :sitter_id, presence: true
  validates :start,     presence: true
  validates :title,     inclusion: { in: ["busy"] }
end
