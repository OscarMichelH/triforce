FactoryBot.define do
  factory :sale do
    id {rand(1_000_000)}
    book_id {1}
    user_id {1}
    app_fee {1.0}
  end
end