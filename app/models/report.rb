# frozen_string_literal: true

class Report < ApplicationRecord
  belongs_to :user
  has_one_attached :raw_report

  has_many :operations

  validates :raw_report, presence: true, size: { less_than: 10.megabytes, message: 'size not allowed' }
end
