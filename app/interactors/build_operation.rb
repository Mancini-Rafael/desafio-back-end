# frozen_string_literal: true

class BuildOperation
  include Interactor

  # {
  #   lines: Array,
  #   report: Report
  # }

  before :verify_params

  OPERATION_INDEX_LENGTH_CORRESPONDENCE = {
    mode: { s: 0, l: 1 },
    date: { s: 1, l: 8 },
    value: { s: 9, l: 10 },
    receiver_cpf: { s: 19, l: 11 },
    card: { s: 30, l: 12 },
    time: { s: 42, l: 6 },
    store_owner: { s: 48, l: 14 },
    store_name: { s: 62, l: 19 }
  }.freeze

  def call
    context.operations = []
    context.errors = []
    context.lines.each do |line|
      operation_raw = {}
      OPERATION_INDEX_LENGTH_CORRESPONDENCE.keys.each do |k|
        operation_raw[k] = line.slice(OPERATION_INDEX_LENGTH_CORRESPONDENCE[k][:s], OPERATION_INDEX_LENGTH_CORRESPONDENCE[k][:l])
      end
      operation_formatted = Operation.new(
        report_id: context.report.id,
        mode: Operation::OPERATION_MODE_CORRESPONDENCE[operation_raw[:mode].to_i],
        date: DateTime.parse("#{operation_raw[:date]} #{operation_raw[:time]} -3"),
        receiver_cpf: operation_raw[:receiver_cpf],
        card: operation_raw[:card],
        store_owner_name: operation_raw[:store_owner].strip,
        store_name: operation_raw[:store_name].strip,
        amount: Money.new(operation_raw[:value].to_f) * operation_signal(operation_raw[:mode].to_i)
      )
      if operation_formatted.valid?
        context.operations << operation_formatted
      else
        context.errors << operation_formatted
      end
    end
  end

  def operation_signal(index)
    negative_modes = [2, 3, 9]
    negative_modes.include?(index) ? -1 : 1
  end

  def verify_params
    context.fail!(errors: ['Missing lines']) unless context.lines.present?
    context.fail!(errors: ['Missing report']) unless context.report.present?
  end
end
