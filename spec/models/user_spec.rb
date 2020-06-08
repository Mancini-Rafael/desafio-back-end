require 'rails_helper'

RSpec.describe User, type: :model do
  subject { FactoryBot.create(:user) }

  it "can be instantiated" do
    expect(User.new).to be_a User
  end

  it "has a valid factory" do
    expect(subject).to be_persisted
  end

  it "validates the format of the email" do
    expect(subject.update_attributes(email: "not_valid_email")).to eq(false)
    expect(subject.errors.include?(:email)).to eq(true)
  end

  it "#from_omniauth creates and returns a valid user" do
    auth_response = OpenStruct.new({provider: 'github', uid: '1234567890', info: OpenStruct.new({ email: 'teste@teste.com' }) } )
    user = User.from_omniauth(auth_response)
    expect(user.valid?).to eq(true)
    expect(user).to be_persisted
    same_user = User.from_omniauth(auth_response)
    expect(same_user == user).to eq(true)
  end
end
