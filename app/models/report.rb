class Report < ApplicationRecord
  belongs_to :user
  has_one_attached :raw_report

  has_many :operations
end
