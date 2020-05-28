User.create!(
  [
    {
      name:  "山田 良子",
      email: "yamada@example.com",
      password:              "foobar",
      password_confirmation: "foobar",
      admin: true,
    },
    {
      name:  "鈴木 恵子",
      email: "suzuki@example.com",
      password:              "password",
      password_confirmation: "password",
    },
    {
      name:  "採用 太郎",
      email: "recruit@example.com",
      password:              "password",
      password_confirmation: "password",
    },
  ]
)

# フォロー関係
user1 = User.find(1)
user2 = User.find(2)
user3 = User.find(3)
user3.follow(user1)
user3.follow(user2)

# 投稿
place = "大阪市"
description1 = "ラテアートがアートです。"
description2 = "酸味があるコーヒーがメインです。"
description3 = "豆も買えます！"
cafememo1 = "店主さん愛想がいい！"
cafememo2 = "あまり好みの味ではなかった。"
cafememo3 = "また行きたい！"

## 3ユーザー、それぞれ5投稿ずつ作成
Post.create!(
  [
    {
      name: "YARDcoffee",
      user_id: 1,
      description: description1,
      place: place,
      reference: "http://yardosaka.com/jp/",
      popularity: 5,
      cafememo: cafememo1,
      picture: open("#{Rails.root}/public/images/post1.jpg"),
      menus_attributes: [
                          { name: "アイスコーヒー", price: "300円" },
                          { name: "焼菓子", price: "648円" },
                          { name: "", price: "" },
                          { name: "", price: "" },
                          { name: "", price: "" },
                          { name: "", price: "" },
                          { name: "", price: "" },
                          { name: "", price: "" },
                          { name: "", price: "" },
                          { name: "", price: "" }
                        ],
    },
    {
      name: "Mel Coffee Roasters",
      user_id: 2,
      description: description2,
      place: place,
      reference: "https://melcoffee.stores.jp/",
      popularity: 4,
      cafememo: cafememo1,
      picture: open("#{Rails.root}/public/images/post2.jpg"),
      menus_attributes: [
                          { name: "アイスコーヒー", price: "400円" },
                          { name: "豆", price: "2000円" },
                          { name: "", price: "" },
                          { name: "", price: "" },
                          { name: "", price: "" },
                          { name: "", price: "" },
                          { name: "", price: "" },
                          { name: "", price: "" },
                          { name: "", price: "" },
                          { name: "", price: "" }
                        ],
    },
    {
      name: "MORNING GLASS COFFEE",
      user_id: 3,
      description: description3,
      place: place,
      reference: "http://kailuahouse.jp/",
      popularity: 4,
      cafememo: cafememo1,
      picture: open("#{Rails.root}/public/images/post3.jpg"),
      menus_attributes: [
                          { name: "アイスコーヒー", price: "600円" },
                          { name: "ハンバーガー", price: "1000円" },
                          { name: "", price: "" },
                          { name: "", price: "" },
                          { name: "", price: "" },
                          { name: "", price: "" },
                          { name: "", price: "" },
                          { name: "", price: "" },
                          { name: "", price: "" },
                          { name: "", price: "" }
                        ],
    },
    {
      name: "LiLo Coffee Roasters",
      user_id: 1,
      description: description2,
      place: place,
      reference: "http://liloinveve.com/coffee/",
      popularity: 3,
      cafememo: cafememo2,
      picture: open("#{Rails.root}/public/images/post4.jpg"),
      menus_attributes: [
                          { name: "アイスコーヒー", price: "100円" },
                          { name: "豆", price: "100円" },
                          { name: "", price: "" },
                          { name: "", price: "" },
                          { name: "", price: "" },
                          { name: "", price: "" },
                          { name: "", price: "" },
                          { name: "", price: "" },
                          { name: "", price: "" },
                          { name: "", price: "" }
                        ],
    },
    {
      name: "SPORTY COFFEE",
      user_id: 2,
      description: description3,
      place: place,
      reference: "https://sporty.coffee/",
      popularity: 5,
      cafememo: cafememo3,
      picture: open("#{Rails.root}/public/images/post5.jpg"),
      menus_attributes: [
                          { name: "カフェモカ", price: "100円" },
                          { name: "Tシャツ", price: "300円" },
                          { name: "", price: "" },
                          { name: "", price: "" },
                          { name: "", price: "" },
                          { name: "", price: "" },
                          { name: "", price: "" },
                          { name: "", price: "" },
                          { name: "", price: "" },
                          { name: "", price: "" }
                        ],
    },
    {
      name: "ELMERS GREEN CAFÉ",
      user_id: 3,
      description: description2,
      place: place,
      reference: "https://elmersgreen.com/",
      popularity: 3,
      cafememo: cafememo2,
      picture: open("#{Rails.root}/public/images/post6.jpg"),
      menus_attributes: [
                          { name: "アイスコーヒー", price: "300円" },
                          { name: "ドリップコーヒー", price: "500円" },
                          { name: "", price: "" },
                          { name: "", price: "" },
                          { name: "", price: "" },
                          { name: "", price: "" },
                          { name: "", price: "" },
                          { name: "", price: "" },
                          { name: "", price: "" },
                          { name: "", price: "" }
                        ],
    },
    {
      name: "TAKAMURACoffee Roasters",
      user_id: 1,
      description: description3,
      place: place,
      reference: "http://takamuranet.com/",
      popularity: 5,
      cafememo: cafememo1,
      picture: open("#{Rails.root}/public/images/post7.jpg"),
      menus_attributes: [
                          { name: "アイスコーヒー", price: "250円" },
                          { name: "ワイン", price: "1000円" },
                          { name: "チーズ", price: "50円" },
                          { name: "", price: "" },
                          { name: "", price: "" },
                          { name: "", price: "" },
                          { name: "", price: "" },
                          { name: "", price: "" },
                          { name: "", price: "" },
                          { name: "", price: "" }
                        ],
    },
    {
      name: "BAR ZUMACCINO",
      user_id: 2,
      description: description2,
      place: place,
      reference: "https://www.facebook.com/BAR-Zumaccino-%E3%83%90%E3%83%BC%E3%83%AB-%E3%82%BA%E3%83%9E%E3%83%83%E3%83%81%E3%83%BC%E3%83%8E-319864014821630/",
      popularity: 4,
      cafememo: cafememo2,
      picture: open("#{Rails.root}/public/images/post8.jpg"),
      menus_attributes: [
                          { name: "ラテアート", price: "140円" },
                          { name: "チョコ", price: "100円" },
                          { name: "豆", price: "2000円" },
                          { name: "", price: "" },
                          { name: "", price: "" },
                          { name: "", price: "" },
                          { name: "", price: "" },
                          { name: "", price: "" },
                          { name: "", price: "" },
                          { name: "", price: "" }
                        ],
    },
    {
      name: "BROOKLYN ROASTING",
      user_id: 3,
      description: description3,
      place: place,
      reference: "http://brooklynroasting.jp/",
      popularity: 5,
      cafememo: cafememo3,
      picture: open("#{Rails.root}/public/images/post9.jpg"),
      menus_attributes: [
                          { name: "コーヒ各種", price: "200円" },
                          { name: "Tシャツ", price: "2000円" },
                          { name: "マグカップ", price: "200円" },
                          { name: "豆各種", price: "1500円" },
                          { name: "", price: "" },
                          { name: "", price: "" },
                          { name: "", price: "" },
                          { name: "", price: "" },
                            { name: "", price: "" },
                          { name: "", price: "" }
                        ],
    },
    {
      name: "ALLDAYCOFFEE",
      user_id: 1,
      description: description3,
      place: place,
      reference: "http://www.transit-web.com/shop/all_day_coffee/",
      popularity: 5,
      cafememo: cafememo1,
      picture: open("#{Rails.root}/public/images/post10.jpg"),
      menus_attributes: [
                          { name: "アイスコーヒー", price: "400円" },
                          { name: "チョコ", price: "100円" },
                          { name: "", price: "" },
                          { name: "", price: "" },
                          { name: "", price: "" },
                          { name: "", price: "" },
                          { name: "", price: "" },
                          { name: "", price: "" },
                          { name: "", price: "" },
                          { name: "", price: "" }
                        ],
    },
    {
      name: "KIELOCOFFEE",
      user_id: 2,
      description: description1,
      place: place,
      reference: "https://www.kielocoffee.com/",
      popularity: 3,
      cafememo: cafememo1,
      picture: open("#{Rails.root}/public/images/post11.jpg"),
      menus_attributes: [
                          { name: "ホットコーヒ", price: "600円" },
                          { name: "水出しコーヒー", price: "400円" },
                          { name: "みかん", price: "100円" },
                          { name: "団子", price: "80円" },
                          { name: "", price: "" },
                          { name: "", price: "" },
                          { name: "", price: "" },
                          { name: "", price: "" },
                          { name: "", price: "" },
                          { name: "", price: "" }
                        ],
    },
    {
      name: "GRATBROWNRoastandBake",
      user_id: 3,
      description: description1,
      place: place,
      reference: "https://www.instagram.com/gratbrown_tokyo/?hl=ja",
      popularity: 4,
      cafememo: cafememo2,
      picture: open("#{Rails.root}/public/images/post12.jpg"),
      menus_attributes: [
                          { name: "アイスコーヒー", price: "500円" },
                          { name: "ハンドドリップコーヒー", price: "3000円" },
                          { name: "水出しコーヒー", price: "300円" },
                          { name: "本日のおすすめ", price: "200円" },
                          { name: "パン", price: "100円" },
                          { name: "チョコ", price: "500円" },
                          { name: "", price: "" },
                          { name: "", price: "" },
                          { name: "", price: "" },
                          { name: "", price: "" }
                        ],
    },
    {
      name: "KITASANDOCOFFEE",
      user_id: 1,
      description: description1,
      place: place,
      reference: "https://kitasandocoffee.com/",
      popularity: 5,
      cafememo: cafememo3,
      picture: open("#{Rails.root}/public/images/post13.jpg"),
      menus_attributes: [
                          { name: "アイスコーヒー", price: "500円" },
                          { name: "バニラアイス", price: "200円" },
                          { name: "", price: "" },
                          { name: "", price: "" },
                          { name: "", price: "" },
                          { name: "", price: "" },
                          { name: "", price: "" },
                          { name: "", price: "" },
                          { name: "", price: "" },
                          { name: "", price: "" }
                        ],
    },
    {
      name: "No.",
      user_id: 2,
      description: description2,
      place: place,
      reference: "https://www.instagram.com/no.tokyo/",
      popularity: 4,
      cafememo: cafememo1,
      picture: open("#{Rails.root}/public/images/post14.jpg"),
      menus_attributes: [
                          { name: "アイスコーヒー", price: "400円" },
                          { name: "豆", price: "100円" },
                          { name: "チョコ", price: "120円" },
                          { name: "チーズケーキ", price: "600円" },
                          { name: "", price: "" },
                          { name: "", price: "" },
                          { name: "", price: "" },
                          { name: "", price: "" },
                          { name: "", price: "" },
                          { name: "", price: "" }
                        ],
    },
    {
      name: "KANNONCOFFEEshoinjinja",
      user_id: 3,
      description: description1,
      place: place,
      reference: "https://www.kannoncoffee.com/",
      popularity: 5,
      cafememo: cafememo3,
      picture: open("#{Rails.root}/public/images/post15.jpg"),
      menus_attributes: [
                          { name: "アイスコーヒー", price: "150円" },
                          { name: "ドリップコーヒー", price: "120円" },
                          { name: "水出しコーヒー", price: "100円" },
                          { name: "ホットコーヒー", price: "180円" },
                          { name: "ラテ", price: "500円" },
                          { name: "モカ", price: "120円" },
                          { name: "チーズケーキ", price: "1000円" },
                          { name: "チョコレートケーキ", price: "400円" },
                          { name: "タルト", price: "300円" },
                          { name: "本日のおすすめ", price: "500円" }
                        ],
    }
  ]
)

post3 = Post.find(3)
post6 = Post.find(6)
post12 = Post.find(12)
post13 = Post.find(13)
post14 = Post.find(14)
post15 = Post.find(15)

# お気に入り登録
user3.favorite(post13)
user3.favorite(post14)
user1.favorite(post15)
user2.favorite(post12)

# コメント
post15.comments.create(user_id: user1.id, content: "美味しそう！私も行ってみたい！")
post12.comments.create(user_id: user2.id, content: "また行こー！")

# 通知
user3.notifications.create(user_id: user3.id, post_id: post15.id,
                           from_user_id: user1.id, variety: 1)
user3.notifications.create(user_id: user3.id, post_id: post15.id,
                           from_user_id: user1.id, variety: 2, content: "美味しそう！私も行ってみたい！")
user3.notifications.create(user_id: user3.id, post_id: post12.id,
                           from_user_id: user2.id, variety: 1)
user3.notifications.create(user_id: user3.id, post_id: post12.id,
                           from_user_id: user2.id, variety: 2, content: "また行こー！")
# リスト
user3.list(post3)
user1.list(post15)
user3.list(post6)
user2.list(post12)

# ログ
Post.all.each do |post|
  Log.create!(post_id: post.id,
              content: post.cafememo)
end
