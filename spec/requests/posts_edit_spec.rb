require "rails_helper"

RSpec.describe "投稿編集", type: :request do
  let!(:user) { create(:user) }
  let!(:other_user) { create(:user) }
  let!(:posts) { create(:post, user: user) }
  let(:picture2_path) { File.join(Rails.root, 'spec/fixtures/test_post2.jpg') }
  let(:picture2) { Rack::Test::UploadedFile.new(picture2_path) }

  context "認可されたユーザーの場合" do
    it "レスポンスが正常に表示されること(+フレンドリーフォワーディング)" do
      get edit_post_path(posts)
      login_for_request(user)
      expect(response).to redirect_to edit_post_url(posts)
      patch post_path(posts), params: { post: { name: "カフェ・ラテアート",
                                               description: "ラテアートがすごい",
                                               place: "東京",
                                               reference: "https://bluebottlecoffee.jp/",
                                               popularity: 5,
                                               picture: picture2,
                                               menus_attributes: [
                                                name: "ラテアート",
                                                price: "200円"] } }
      redirect_to posts
      follow_redirect!
      expect(response).to render_template('posts/show')
    end
  end

  context "ログインしていないユーザーの場合" do
    it "ログイン画面にリダイレクトすること" do
      get edit_post_path(posts)
      expect(response).to have_http_status "302"
      expect(response).to redirect_to login_path

      patch post_path(posts), params: { post: { name: "カフェ・ラテアート",
                                                description: "ラテアートがすごい",
                                                place: "東京",
                                                reference: "https://bluebottlecoffee.jp/",
                                                popularity: 5 } }
      expect(response).to have_http_status "302"
      expect(response).to redirect_to login_path
    end
  end

  context "別アカウントのユーザーの場合" do
    it "ホーム画面にリダイレクトすること" do
      login_for_request(other_user)
      get edit_post_path(posts)
      expect(response).to have_http_status "302"
      expect(response).to redirect_to root_path

      patch post_path(posts), params: { post: { name: "カフェ・ラテアート",
                                                description: "ラテアートすごい",
                                                place: "東京",
                                                reference: "https://bluebottlecoffee.jp/",
                                                popularity: 5 } }
      expect(response).to have_http_status "302"
      expect(response).to redirect_to root_path
    end
  end
end