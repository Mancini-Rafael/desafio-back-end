FactoryBot.define do
  factory :report do
    user
    raw_report { Rack::Test::UploadedFile.new('spec/examples/CNAB.txt', 'text/txt') }

    trait :invalid do
      raw_report { nil }
    end
  end
end
