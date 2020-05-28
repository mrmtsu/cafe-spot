require 'rails_helper'

RSpec.describe "Posts", type: :system do
  let!(:user) { create(:user) }
  let!(:other_user) { create(:user) }
  let!(:posts) { create(:post, :picture, :menus,  user: user) }
  let!(:comment) { create(:comment, user_id: user.id, post: posts) }
  let!(:log) { create(:log, post: posts) }

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
        expect(page).to have_css 'label[for=post_menus_attributes_0_name]',
                               text: 'メニュー名（10種類まで登録可）', count: 1
        expect(page).to have_css 'label[for=post_menus_attributes_0_price]',
                               text: '金額', count: 1
        expect(page).to have_content 'URL'
        expect(page).to have_content 'おすすめ度 [1~5]'
      end

      it "メニュー入力部分が10行表示されること" do
        expect(page).to have_css 'input.menu_name', count: 10
        expect(page).to have_css 'input.menu_price', count: 10
      end
    end

    context "投稿登録処理" do
      it "有効な情報で投稿登録を行うと投稿登録成功のフラッシュが表示されること" do
        fill_in "店名", with: "カフェ・ラテアート"
        fill_in "説明", with: "ラテアートがすごい"
        fill_in "場所", with: "東京"
        fill_in "post[menus_attributes][0][name]", with: "豆"
        fill_in "post[menus_attributes][0][price]", with: "200円"
        fill_in "URL", with: "https://bluebottlecoffee.jp/"
        fill_in "おすすめ度", with: 5
        attach_file "post[picture]", "#{Rails.root}/spec/fixtures/test_post.jpg"
        click_button "登録する"
        expect(page).to have_content "投稿が登録されました！"
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
        posts.menus.each do |i|
          expect(page).to have_content i.name
          expect(page).to have_content i.price
        end
      end

      context "コメントの登録＆削除" do
        it "自分の投稿に対するコメントの登録＆削除が正常に完了すること" do
          login_for_system(user)
          visit post_path(posts)
          fill_in "comment_content", with: "今日の味付けは大成功"
          click_button "コメント"
          within find("#comment-#{Comment.last.id}") do
            expect(page).to have_selector 'span', text: user.name
            expect(page).to have_selector 'span', text: '今日の味付けは大成功'
          end
          expect(page).to have_content "コメントを追加しました！"
          click_link "削除", href: comment_path(Comment.last)
          expect(page).not_to have_selector 'span', text: '今日の味付けは大成功'
          expect(page).to have_content "コメントを削除しました"
        end
  
        it "別ユーザーの投稿のコメントには削除リンクが無いこと" do
          login_for_system(other_user)
          visit post_path(posts)
          within find("#comment-#{comment.id}") do
            expect(page).to have_selector 'span', text: user.name
            expect(page).to have_selector 'span', text: comment.content
            expect(page).not_to have_link '削除', href: post_path(posts)
          end
        end
      end
    end

    context "ログ登録＆削除" do
      context "投稿詳細ページから" do
        it "自分の投稿に対するログ登録＆削除が正常に完了すること" do
          login_for_system(user)
          visit post_path(posts)
          fill_in "log_content", with: "朝が狙い目"
          click_button "ログ追加"
          within find("#log-#{Log.first.id}") do
            expect(page).to have_selector 'span', text: "#{posts.logs.count}回目"
            expect(page).to have_selector 'span',
                                          text: %Q(#{Log.last.created_at.strftime("%Y/%m/%d(%a)")})
            expect(page).to have_selector 'span', text: '朝が狙い目'
          end
          expect(page).to have_content "カフェログを追加しました！"
          click_link "削除", href: log_path(Log.first)
          expect(page).to have_content "カフェログを削除しました"
        end

        it "別ユーザーの投稿ログにはログ登録フォームが無いこと" do
          login_for_system(other_user)
          visit post_path(posts)
          expect(page).not_to have_button "作る"
        end
      end

      context "トップページから" do
        it "自分の投稿に対するログ登録が正常に完了すること" do
          login_for_system(user)
          visit root_path
          fill_in "log_content", with: "朝が狙い目"
          click_button "追加"
          expect(Log.first.content).to eq '朝が狙い目'
          expect(page).to have_content "カフェログを追加しました！"
        end

        it "別ユーザーの投稿にはログ登録フォームがないこと" do
          create(:post, user: other_user)
          login_for_system(user)
          user.follow(other_user)
          visit root_path
          within find("#post-#{Post.first.id}") do
            expect(page).not_to have_button "作る"
          end
        end
      end

      context "プロフィールページから" do
        it "自分の投稿に対するログ登録が正常に完了すること" do
          login_for_system(user)
          visit user_path(user)
          fill_in "log_content", with: "朝が狙い目"
          click_button "追加"
          expect(Log.first.content).to eq '朝が狙い目'
          expect(page).to have_content "カフェログを追加しました！"
        end
      end

      context "リスト一覧ページから" do
        it "自分の投稿に対するログ登録が正常に完了し、リストから投稿が削除されること" do
          login_for_system(user)
          user.list(posts)
          visit lists_path
          expect(page).to have_content posts.name
          fill_in "log_content", with: "朝が狙い目"
          click_button "追加"
          expect(Log.first.content).to eq '朝が狙い目'
          expect(page).to have_content "カフェログを追加しました！"
          expect(List.count).to eq 0
        end
      end

      context "検索機能" do
        context "ログインしている場合" do
          before do
            login_for_system(user)
            visit root_path
          end
    
          it "ログイン後の各ページに検索窓が表示されていること" do
            expect(page).to have_css 'form#post_search'
            visit about_path
            expect(page).to have_css 'form#post_search'
            visit use_of_terms_path
            expect(page).to have_css 'form#post_search'
            visit users_path
            expect(page).to have_css 'form#post_search'
            visit user_path(user)
            expect(page).to have_css 'form#post_search'
            visit edit_user_path(user)
            expect(page).to have_css 'form#post_search'
            visit following_user_path(user)
            expect(page).to have_css 'form#post_search'
            visit followers_user_path(user)
            expect(page).to have_css 'form#post_search'
            visit posts_path
            expect(page).to have_css 'form#post_search'
            visit post_path(posts)
            expect(page).to have_css 'form#post_search'
            visit new_post_path
            expect(page).to have_css 'form#post_search'
            visit edit_post_path(posts)
            expect(page).to have_css 'form#post_search'
          end
    
          it "フィードの中から検索ワードに該当する結果が表示されること" do
            create(:post, name: 'かに玉', user: user)
            create(:post, name: 'かに鍋', user: other_user)
            create(:post, name: '野菜炒め', user: user)
            create(:post, name: '野菜カレー', user: other_user)

            fill_in 'q_name_or_menus_name_cont', with: 'かに'
            click_button '検索'
            expect(page).to have_css 'h3', text: "”かに”の検索結果：1件"
            within find('.posts') do
              expect(page).to have_css 'li', count: 1
            end
            fill_in 'q_name_or_menus_name_cont', with: '野菜'
            click_button '検索'
            expect(page).to have_css 'h3', text: "”野菜”の検索結果：1件"
            within find('.posts') do
              expect(page).to have_css 'li', count: 1
            end

            user.follow(other_user)
            fill_in 'q_name_or_menus_name_cont', with: 'かに'
            click_button '検索'
            expect(page).to have_css 'h3', text: "”かに”の検索結果：2件"
            within find('.posts') do
              expect(page).to have_css 'li', count: 2
            end
            fill_in 'q_name_or_menus_name_cont', with: '野菜'
            click_button '検索'
            expect(page).to have_css 'h3', text: "”野菜”の検索結果：2件"
            within find('.posts') do
              expect(page).to have_css 'li', count: 2
            end
          end
    
          it "検索ワードを入れずに検索ボタンを押した場合、投稿一覧が表示されること" do
            fill_in 'q_name_or_menus_name_cont', with: ''
            click_button '検索'
            expect(page).to have_css 'h3', text: "投稿一覧"
            within find('.posts') do
              expect(page).to have_css 'li', count: Post.count
            end
          end
        end
    
        context "ログインしていない場合" do
          it "検索窓が表示されないこと" do
            visit root_path
            expect(page).not_to have_css 'form#post_search'
          end
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
        expect(page).to have_css 'p.title-menu-name', text: 'メニュー名（10種類まで登録可）', count: 1
        expect(page).to have_css 'p.title-menu-price', text: '金額', count: 1
        expect(page).to have_content 'URL'
        expect(page).to have_content 'おすすめ度 [1~5]'
      end

      it "メニュー入力部分が10行表示されること" do
        expect(page).to have_css 'input.menu_name', count: 10
        expect(page).to have_css 'input.menu_price', count: 10
      end
    end

    context "投稿の更新処理" do
      it "有効な更新" do
        fill_in "店名", with: "編集:カフェ・ラテアート"
        fill_in "説明", with: "ラテアートがすごい"
        fill_in "場所", with: "編集:東京"
        fill_in "post[menus_attributes][0][name]", with: "編集-アイスコーヒー"
        fill_in "post[menus_attributes][0][price]", with: "編集-1円"
        fill_in "URL", with: "https://bluebottlecoffee.jp/"
        fill_in "おすすめ度", with: 5
        attach_file "post[picture]", "#{Rails.root}/spec/fixtures/test_post2.jpg"
        click_button "更新する"
        expect(page).to have_content "投稿情報が更新されました！"
        expect(posts.reload.name).to eq "編集:カフェ・ラテアート"
        expect(posts.reload.description).to eq "ラテアートがすごい"
        expect(posts.reload.place).to eq "編集:東京"
        expect(posts.reload.menus.first.name).to eq "編集-アイスコーヒー"
        expect(posts.reload.menus.first.price).to eq "編集-1円"
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
  end
end
