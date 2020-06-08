# frozen_string_literal: true

class Operation < ApplicationRecord
  belongs_to :report

  OPERATION_MODE_CORRESPONDENCE = {
    1 => 'debit',
    2 => 'boleto',
    3 => 'financing',
    4 => 'credit',
    5 => 'loan_receiver',
    6 => 'sale',
    7 => 'ted_receiver',
    8 => 'doc_receiver',
    9 => 'rent'
  }.freeze

  validates :mode, inclusion: { in: OPERATION_MODE_CORRESPONDENCE.values }
  OPERATION_MODE_CORRESPONDENCE.values.each do |s|
    scope s, -> { where(mode: s) }
  end
  monetize :amount_cents
end
