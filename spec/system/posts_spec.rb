require 'rails_helper'

RSpec.describe "Posts", type: :system do
  let!(:user) { create(:user) }
  let!(:posts) { create(:post, :picture, user: user) }

  describe "投稿登録ページ" do
    before do
      login_for_system(user)
      visit new_post_path
    end

    context "ページレイアウト" do
      it "「投稿登録」の文字列が存在すること" do
        expect(page).to have_content '投稿登録'
      end

      it "正しいタイトルが表示されること" do
        expect(page).to have_title full_title('投稿登録')
      end

      it "入力部分に適切なラベルが表示されること" do
        expect(page).to have_content '店名'
        expect(page).to have_content '説明'
        expect(page).to have_content '場所'
        expect(page).to have_content 'URL'
        expect(page).to have_content 'おすすめ度 [1~5]'
      end
    end

    context "投稿登録処理" do
      it "有効な情報で投稿登録を行うと投稿登録成功のフラッシュが表示されること" do
        fill_in "店名", with: "カフェ・ラテアート"
        fill_in "説明", with: "ラテアートがすごい"
        fill_in "場所", with: "東京"
        fill_in "URL", with: "https://bluebottlecoffee.jp/"
        fill_in "おすすめ度", with: 5
        attach_file "post[picture]", "#{Rails.root}/spec/fixtures/test_post.jpg"
        click_button "登録する"
        expect(page).to have_content "投稿が登録されました！"
      end

      it "画像無しで登録すると、デフォルト画像が割り当てられること" do
        fill_in "店名", with: "カフェ・ラテアート"
        click_button "登録する"
        expect(page).to have_link(href: post_path(Post.first))
      end

      it "無効な情報で投稿登録を行うと投稿登録失敗のフラッシュが表示されること" do
        fill_in "店名", with: ""
        fill_in "説明", with: "ラテアートがすごい"
        fill_in "場所", with: "東京"
        fill_in "URL", with: "https://bluebottlecoffee.jp/"
        fill_in "おすすめ度", with: 5
        click_button "登録する"
        expect(page).to have_content "店名を入力してください"
      end
    end
  end

  describe "投稿詳細ページ" do
    context "ページレイアウト" do
      before do
        login_for_system(user)
        visit post_path(posts)
      end

      it "正しいタイトルが表示されていること" do
        expect(page).to have_title full_title("#{posts.name}")
      end

      it "投稿情報が表示されること" do
        expect(page).to have_content posts.name
        expect(page).to have_content posts.description
        expect(page).to have_content posts.place
        expect(page).to have_content posts.reference
        expect(page).to have_content posts.popularity
        expect(page).to have_link nil, href: post_path(posts), class: 'post-picture'
      end

      context "投稿の削除", js: true do
        it "削除成功のフラッシュが表示されること" do
          login_for_system(user)
          visit post_path(posts)
          within find('.change-post') do
            click_on '削除'
          end
          page.driver.browser.switch_to.alert.accept
          expect(page).to have_content '投稿が削除されました'
        end
      end
    end
  end

  describe "投稿編集ページ" do
    before do
      login_for_system(user)
      visit post_path(posts)
      click_link "編集"
    end

    context "ページレイアウト" do
      it "正しいタイトルが表示されること" do
        expect(page).to have_title full_title('投稿情報の編集')
      end

      it "入力部分に適切なラベルが表示されること" do
        expect(page).to have_content '店名'
        expect(page).to have_content '説明'
        expect(page).to have_content '場所'
        expect(page).to have_content 'URL'
        expect(page).to have_content 'おすすめ度 [1~5]'
      end
    end

    context "投稿の更新処理" do
      it "有効な更新" do
        fill_in "店名", with: "編集:カフェ・ラテアート"
        fill_in "説明", with: "ラテアートがすごい"
        fill_in "場所", with: "編集:東京"
        fill_in "URL", with: "https://bluebottlecoffee.jp/"
        fill_in "おすすめ度", with: 5
        attach_file "post[picture]", "#{Rails.root}/spec/fixtures/test_post2.jpg"
        click_button "更新する"
        expect(page).to have_content "投稿情報が更新されました！"
        expect(posts.reload.name).to eq "編集:カフェ・ラテアート"
        expect(posts.reload.description).to eq "ラテアートがすごい"
        expect(posts.reload.place).to eq "編集:東京"
        expect(posts.reload.reference).to eq "https://bluebottlecoffee.jp/"
        expect(posts.reload.popularity).to eq 5
        expect(posts.reload.picture.url).to include "test_post2.jpg"
      end

      it "無効な更新" do
        fill_in "店名", with: ""
        click_button "更新する"
        expect(page).to have_content '店名を入力してください'
        expect(posts.reload.name).not_to eq ""
      end
    end

    context "投稿の削除処理", js: true do
      it "削除成功のフラッシュが表示されること" do
        click_on '削除'
        page.driver.browser.switch_to.alert.accept
        expect(page).to have_content '投稿が削除されました'
      end
    end
  end
end
