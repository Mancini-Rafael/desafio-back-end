class ReportsController < ApplicationController
  before_action :authenticate_user!

  def index
    @msg = "You're in"
  end
end
