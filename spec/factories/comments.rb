FactoryBot.define do
  factory :comment do
    user_id { 1 }
    content { "これぞアート。" }
    association :post
  end
end
