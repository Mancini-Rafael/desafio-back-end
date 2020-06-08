require 'rails_helper'

RSpec.describe ParseCnab, type: :interactor do
  before(:each) do
    allow(ReadFile).to receive(:call!) { :success }
    allow(BuildOperation).to receive(:call!) { :success }
    allow(CommitOperation).to receive(:call!) { :success }
  end

  it { expect(ParseCnab.organized).to eq([ReadFile, BuildOperation, CommitOperation]) }
end