FactoryBot.define do
  factory :menu do
    name { "アイスコーヒー" }
    price { "100円" }
    association :post
  end
end
