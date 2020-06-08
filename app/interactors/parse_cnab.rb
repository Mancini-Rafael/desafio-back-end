# frozen_string_literal: true

class ParseCnab
  include Interactor::Organizer

  # {
  #   report: Report
  # }
  organize ReadFile, BuildOperation, CommitOperation
end
