# frozen_string_literal: true

class ReadFile
  include Interactor

  # {
  #   report: Report
  # }
  before :verify_params

  def call
    data = context.report.raw_report.download
    context.lines = []
    data.each_line do |line|
      context.lines << line.strip
    end
  end

  def verify_params
    context.fail!(errors: ['Missing report']) unless context.report.present?
    context.fail!(errors: ['Report does not contain valid file']) if context.report.raw_report.attachment.nil?
  end
end
