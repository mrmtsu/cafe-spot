require "rails_helper"

RSpec.describe "投稿登録", type: :request do
  let!(:user) { create(:user) }
  let!(:other_user) { create(:user) }
  let!(:posts) { create(:post, user: user) }
  let(:picture_path) { File.join(Rails.root, 'spec/fixtures/test_post.jpg') }
  let(:picture) { Rack::Test::UploadedFile.new(picture_path) }

  context "ログインしているユーザーの場合" do
    before do
      get new_post_path
      login_for_request(user)
    end

    context "フレンドリーフォワーディング" do
      it "レスポンスが正常に表示されること" do
        expect(response).to redirect_to new_post_url
      end
    end

    it "有効な投稿データで登録できること" do
      expect {
        post posts_path, params: { post: { name: "カフェ・ラテアート",
                                           description: "ラテアートがすごい",
                                           place: "東京",
                                           reference: "https://bluebottlecoffee.jp/",
                                           popularity: 5,
                                           picture: picture } }
        }.to change(Post, :count).by(1)
        follow_redirect!
        expect(response).to render_template('posts/show')
    end

    it "無効な投稿データでは登録できないこと" do
      expect {
        post posts_path, params: { post: { name: "",
                                           description: "ラテアートがすごい",
                                           place: "東京",
                                           reference: "https://bluebottlecoffee.jp/",
                                           popularity: 5,
                                           picture: picture } }
      }.not_to change(Post, :count)
      expect(response).to render_template('posts/new')
    end
  end

  context "ログインしていないユーザーの場合" do
    it "ログイン画面にリダイレクトすること" do
      get new_post_path
      expect(response).to have_http_status "302"
      expect(response).to redirect_to login_path
    end
  end
end
