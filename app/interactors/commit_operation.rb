# frozen_string_literal: true

class CommitOperation
  include Interactor

  before :verify_params

  # {
  #   operations: [Operation]
  # }

  def call
    context.report.operations.destroy_all if context.report&.operations&.present?
    context.fail!(errors: ['Error importing operations']) unless Operation.import(context.operations)
  end

  def verify_params
    context.fail!(errors: ['Missing operations']) unless context.operations.present?
  end
end
