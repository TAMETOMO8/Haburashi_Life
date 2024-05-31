require 'rails_helper'

RSpec.describe 'Toothbrushes', type: :system do
  describe 'ログイン前' do
    describe '歯ブラシのページ' do
      context '歯ブラシの検索ページにアクセス' do
        it '検索ページへのアクセスが失敗する' do
          visit toothbrush_search_path
          expect(page).to have_content('ログインしてください')
          expect(current_path).to eq root_path
        end
      end

      describe '歯ブラシのページ' do
        context '歯ブラシの一覧ページにアクセス' do
          it '歯ブラシが登録されていない一覧ページが表示される' do
            visit root_path
            click_on 'みんなの歯ブラシ'
            expect(page).to have_content('使用されている歯ブラシはありません')
          end
          it 'すでに登録されている歯ブラシが一覧ページに表示される' do
            create(:toothbrush)
            visit root_path
            click_on 'みんなの歯ブラシ'
            expect(page).to have_content('使いやすい歯ブラシです!')
          end
          it '一覧ページのページネーションが機能する' do
            create_list(:toothbrush, 25, state: 0)
            visit root_path
            click_on 'みんなの歯ブラシ'
            click_on '2'
            click_on '3'
            click_on '最初へ'
            click_on '最後へ'
            expect(page).to have_content('最初へ')
          end
        end

        context '歯ブラシの詳細ページにアクセス' do
          it '歯ブラシの詳細ページが表示される' do
            create(:toothbrush)
            visit root_path
            click_on 'みんなの歯ブラシ'
            click_on '詳細'
            expect(page).to have_content('使いやすい歯ブラシです!')
          end
        end

        context 'ユーザーの詳細ページにアクセス' do
          it 'ユーザー詳細ページが表示される' do
            create(:toothbrush)
            visit root_path
            click_on 'みんなの歯ブラシ'
            click_on '詳細'
            click_link 'ユーザーの詳細を見る'
            expect(page).to have_content('テストゲストさんのページ')
          end
        end
      end
    end

    describe '新規ログイン' do
      context 'ログインページにアクセス' do
        before do
          create(:user)
          allow_any_instance_of(ApplicationController).to receive(:current_user).and_return('user_session')
        end
        it 'ログインが成功する' do
          visit root_path
          click_on '歯ブラシ'
          click_link '新しい歯ブラシ'
          expect(page).to have_content('使いたい歯ブラシを登録しましょう！')
        end
      end
    end
  end

  describe 'ログイン後' do
    before do
      create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return('user_session')
    end

    context '歯ブラシの検索ページにアクセス' do
      it '検索ページでテキスト入力し、検索に成功する' do
        visit root_path
        click_on '歯ブラシ'
        click_link '新しい歯ブラシ'
        fill_in 'text-form', with: 'NONIO'
        click_on '検索'
        expect(page).not_to have_content 'ごめんなさい！このキーワードを持つ歯ブラシは、楽天市場には無いみたいです・・・'
      end
      it 'ドロップダウンをクリックして入力補完に成功する' do
        visit root_path
        click_on '歯ブラシ'
        click_link '新しい歯ブラシ'
        click_on '主要なメーカーで検索'
        find('a', text: 'LION').click
        click_on '検索'
        expect(page).not_to have_content 'ごめんなさい！このキーワードを持つ歯ブラシは、楽天市場には無いみたいです・・・'
      end
      it '検索ページでテキスト入力せず、検索に失敗する' do
        visit root_path
        click_on '歯ブラシ'
        click_link '新しい歯ブラシ'
        click_on '検索'
        expect(page).to have_content '検索ワードを入力してください'
      end
      it '検索ページで入力したテキストに該当する歯ブラシが見つからず、検索に失敗する' do
        visit root_path
        click_on '歯ブラシ'
        click_link '新しい歯ブラシ'
        fill_in 'text-form', with: 'パソコン'
        click_on '検索'
        expect(page).to have_content 'ごめんなさい！このキーワードを持つ歯ブラシは、楽天市場には無いみたいです・・・'
      end
    end
  end

  describe '環境改善ページ' do
    context '環境改善ページにアクセス' do
      it '改善度が0%で表示される' do
        visit root_path
        click_link '環境改善度を確認する'
        expect(page).to have_content('現在の環境改善度 : 0%')
      end
      it '改善度が30%で表示される' do
        create_list(:toothbrush, 15, state: 4)
        visit root_path
        click_link '環境改善度を確認する'
        expect(page).to have_content('少し綺麗になってきましたね。でも、もっと綺麗にできそうですね?')
      end
      it '改善度が50%で表示される' do
        create_list(:toothbrush, 25, state: 4)
        visit root_path
        click_link '環境改善度を確認する'
        expect(page).to have_content('どんどん綺麗になってきています!この調子で綺麗にしていきましょう!')
      end
      it '改善度が70%で表示される' do
        create_list(:toothbrush, 35, state: 4)
        visit root_path
        click_link '環境改善度を確認する'
        expect(page).to have_content('かなり綺麗になりました!あと一息、みんなで力を合わせましょう!')
      end
      it '改善度が100%で表示される' do
        create_list(:toothbrush, 50, state: 4)
        visit root_path
        click_link '環境改善度を確認する'
        expect(page).to have_content('みなさんのおかげで環境が整いました!おめでとうございます!')
      end
    end
  end
end
