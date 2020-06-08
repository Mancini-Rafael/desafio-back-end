# frozen_string_literal: true

class ProfileController < ApplicationController
  layout 'application'

  def index
    redirect_to(reports_path) if user_signed_in?
  end
end
