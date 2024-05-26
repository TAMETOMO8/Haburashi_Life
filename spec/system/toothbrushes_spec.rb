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

      context '歯ブラシの一覧ページにアクセス' do
        it '歯ブラシが登録されていない一覧ページが表示される' do
          visit toothbrushes_path
          expect(page).to have_content('使用されている歯ブラシはありません')
        end
      end
    end
  end
end
