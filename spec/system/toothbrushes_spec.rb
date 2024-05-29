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
  end
end
