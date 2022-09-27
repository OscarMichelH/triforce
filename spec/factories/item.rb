FactoryBot.define do
  factory :item do
    id {1}
    title {"BOOK TITLE"}
    description {"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec sollicitudin turpis ac velit convallis, id scelerisque dui rutrum. Vestibulum magna risus, laoreet nec ipsum ac, pharetra ullamcorper dolor."}
    author {"Uknown"}
    price {5.0}
    user_id {1}
  end
end