FactoryBot.define do
  factory :toothbrush do
    sequence(:user_id) { |n| n }
    item_code { 'rakuten24:11109112' }
    item_name { 'ノニオ ハブラシ TYPE-SHARP ふつう(3本セット)【ノニオ(NONIO)' }
    item_url { 'https://item.rakuten.co.jp/rakuten24/532529/' }
    item_image_urls { 'https://thumbnail.image.rakuten.co.jp/@0_mall/rakuten24/cabinet/529/532529.jpg?_ex=128x128' }
    state { 1 }
    brush_material { 0 }
    hardness { 0 }
    end_use_at { Time.current.strftime('%Y-%m-%d') }
    comment { '使いやすい歯ブラシです!' }
    comment_notice { true }
    association :user
  end
end
