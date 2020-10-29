FactoryBot.define do
  factory :warehouse do
    name {Faker::Company.name}
    address {Faker::Address.city}
    balance {0}
  end
end