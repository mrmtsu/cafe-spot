FactoryBot.define do
  factory :post do
    name { "カフェ・ラテアート" }
    description { "ラテアートがすごい" }
    place { "東京都" }
    reference { "https://bluebottlecoffee.jp/" }
    popularity { 5 }
    association :user
    created_at { Time.current }
  end

  trait :menus do
    menus_attributes {
                      [
                        { name: "アイスコーヒー", price: "1円" },
                        { name: "ドリップコーヒー", price: "2円" },
                        { name: "水出しコーヒー", price: "3円" },
                        { name: "カフェラテ", price: "4円" },
                        { name: "カフェモカ", price: "5円" },
                        { name: "ミックスジュース", price: "6円" },
                        { name: "チーズタルト", price: "7円" },
                        { name: "チョコ", price: "8円" },
                        { name: "団子", price: "9円" },
                        { name: "焼菓子", price: "10円" }
                      ]
    }
  end

  trait :yesterday do
    created_at { 1.day.ago }
  end

  trait :one_week_ago do
    created_at { 1.week.ago }
  end

  trait :one_month_ago do
    created_at { 1.month.ago }
  end

  trait :picture do
    picture { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/test_post.jpg')) }
  end
end
