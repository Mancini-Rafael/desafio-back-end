FactoryBot.define do
  factory :operation do
    report
    mode { "debit" } 
    date { DateTime.now }
    card { "6777****1313" }
    receiver_cpf { "111.111.111-11" } 
    store_owner_name { Faker::Name.name }
    store_name { Faker::Company.name }
    amount { Money.new(120_00) }
  end
end
