require 'rails_helper'

RSpec.describe "StaticPages", type: :system do
  describe "トップページ" do
    context "ページ全体" do
      before do
        visit root_path
      end

      it "カフェログの文字列が存在することを確認" do
        expect(page).to have_content 'カフェログ'
      end

      it "正しいタイトルが表示されることを確認" do
        expect(page).to have_title full_title
      end

      context "投稿フィード", js: true do
        let!(:user) { create(:user) }
        let!(:posts) { create(:post, user: user) }

        before do
          login_for_system(user)
        end

        it "投稿のページネーションが表示されること" do
          create_list(:post, 6, user: user)
          visit root_path
          expect(page).to have_content "カフェリスト (#{user.posts.count})"
          expect(page).to have_css "div.pagination"
          Post.take(5).each do |p|
            expect(page).to have_link p.name
          end
        end

        it "「新しい投稿をする」リングが表示されること" do
          visit root_path
          expect(page).to have_link "新しい投稿をする", href: new_post_path
        end

        it "投稿を削除後、削除成功のフラッシュが表示されること" do
          visit root_path
          click_on '削除'
          page.driver.browser.switch_to.alert.accept
          expect(page).to have_content '投稿が削除されました'
        end
      end
    end
  end

  describe "ヘルプページ" do
    before do
      visit about_path
    end

    it "カフェログとは？の文字列が存在することを確認" do
      expect(page).to have_content 'カフェログとは？'
    end

    it "正しいタイトルが表示されることを確認" do
      expect(page).to have_title full_title('カフェログとは？')
    end
  end

  describe "利用規約ページ" do
    before do
      visit use_of_terms_path
    end

    it "利用規約の文字列が存在することを確認" do
      expect(page).to have_content '利用規約'
    end

    it "正しいタイトルが表示されることを確認" do
      expect(page).to have_title full_title('利用規約')
    end
  end
end
