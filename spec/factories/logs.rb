FactoryBot.define do
  factory :log do
    content { "朝が狙い目" }
    association :post
  end
end
