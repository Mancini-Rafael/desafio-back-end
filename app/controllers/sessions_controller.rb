# frozen_string_literal: true

class SessionsController < Devise::SessionsController
  layout 'application'

  skip_before_action :verify_authenticity_token, only: %i[create destroy new]

  def after_sign_out_path_for(_resource_or_scope)
    root_path
  end

  def after_sign_in_path_for(_resource_or_scope)
    reports_path
  end
end
