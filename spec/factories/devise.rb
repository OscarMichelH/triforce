FactoryBot.define do
  factory :user do
    id {rand(1_000_000)}
    email {"buyer1@mail.com"}
    password {"123456"}
    name {"Buyer Name"}
    address {"Buyer Address"}
    balance {50.0}
    role {"BUYER"}
  end
end