class Operation < ApplicationRecord
  belongs_to :report

  NON_VALIDATABLE_ATTRS = ["id", "created_at", "updated_at"]
  VALIDATABLE_ATTRS = Operation.attribute_names.reject{|attr| NON_VALIDATABLE_ATTRS.include?(attr)}
  ALLOWED_TYPES = %w(
    debit
    boleto
    financing
    credit
    loan_receiver
    sale
    ted_receiver
    doc_receiver
    rent
  ).freeze
  
  validates :type, inclusion: { in: ALLOWED_TYPES }
  validates VALIDATABLE_ATTRS, presence: true
  ALLOWED_TYPES.each do |s|
    scope s, -> { where( type: s ) } 
  end
  monetize :amount_cents
end
