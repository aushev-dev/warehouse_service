FactoryBot.define do
  factory :product do
    name {Faker::Book.title}
    count  {300}
    price  {50000}
    warehouse
    sold {false}
  end
end