# frozen_string_literal: true

class ReportsController < ApplicationController
  before_action :authenticate_user!

  def index
    @reports = current_user.reports.includes(:operations).all
  end

  def create
    @report = current_user.reports.build(report_params)
    if @report.save
      redirect_to(reports_path)
    else
      render :new
    end
  end

  def new
    @report = current_user.reports.build
  end

  def parse
    report = Report.find_by(id: params[:report_id])
    if report.present?
      result = ParseCnab.call(report: report)
      if result.success?
        redirect_to report_path(report)
      else
        redirect_to reports_path, alert: 'Error processing report'
      end
    else
      redirect_to reports_path, notice: 'Report not found'
    end
  end

  def show
    @report = Report.find_by(id: params[:id].to_i)
    if @report.present? && @report.user == current_user
      @operations = @report.operations.all
    else
      redirect_to reports_path, notice: 'Report not found or not allowed to access'
    end
  end

  def report_params
    params.require(:report).permit(:raw_report)
  end
end
