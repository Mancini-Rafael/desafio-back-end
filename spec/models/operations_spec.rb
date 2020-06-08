require 'rails_helper'

RSpec.describe Operation, type: :model do
  subject { FactoryBot.create(:operation) }

  it "can be instantiated" do
    expect(Operation.new).to be_a Operation
  end

  it "has a valid factory" do
    expect(subject).to be_persisted
  end
end
