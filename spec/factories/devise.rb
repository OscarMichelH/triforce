FactoryBot.define do
  factory :user do
    id {5}
    email {"buyer1@mail.com"}
    password {"123456"}
    name {"Buyer Name"}
    address {"Buyer Address"}
    balance {50.0}
    role {"BUYER"}
  end

  factory :buyer do
    id {1}
    email {"buyer@mail.com"}
    password {"123456"}
    name {"Buyer Name"}
    address {"Buyer Address"}
    balance {50.0}
    role {"BUYER"}
  end

  factory :seller do
    id {2}
    email {"seller@mail.com"}
    password {"123456"}
    name {"Seler Name"}
    phone {"0123456789"}
    balance {0}
    role {"SELLER"}
  end

  factory :admin do
    id {3}
    email {"admin2@mail.com"}
    password {"123456"}
    balance {1000.0}
    role {"ADMIN"}
  end

end