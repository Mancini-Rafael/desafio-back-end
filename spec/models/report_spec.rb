require 'rails_helper'

RSpec.describe Report, type: :model do
  subject { FactoryBot.create(:report) }

  it "can be instantiated" do
    expect(Report.new).to be_a Report
  end

  it "has a valid factory" do
    expect(subject).to be_persisted
  end

  it "validates the presence of a user" do
    expect(subject.update_attributes(user: nil)).to eq(false)
    expect(subject.errors.include?(:user)).to eq(true)
  end

  it "validates the presence of a raw attached report" do
    expect {subject.update_attributes(raw_report: nil) }.to raise_error (ActiveRecord::RecordNotSaved)
  end

  it "validates the size of a raw attached report" do
    report = Report.new(user: subject.user)
    report.raw_report = Rack::Test::UploadedFile.new('spec/examples/large_file.txt', 'text/txt')
    expect(report.save).to eq(false)
    expect(report.errors.include?(:raw_report)).to eq(true)
  end
end
