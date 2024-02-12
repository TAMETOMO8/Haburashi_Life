namespace :line_message do # rubocop:disable Metrics/BlockLength
  desc '使用終了日を過ぎた歯ブラシを持つユーザーにメッセージを送り、状態を更新する'
  task push_message_and_update: :environment do
    require 'line_message'

    Toothbrush.end_toothbrushed.each do |toothbrush|
      line_user_id = toothbrush.user.line_user_id

      alt_text = "交換日が来た歯ブラシがあります"
      header_text = "歯ブラシの交換のお知らせです！"
      hero_image = toothbrush.item_image_urls.to_s
      item_name = toothbrush.item_name.to_s
      contents_text = "使い終わったあとはどうするかを決めましょう！"
      label_text = "使い方を決める"
      link_uri = "https://www.haburashi-life.com/toothbrushes/#{toothbrush.id}"

      LineMessage.send_message_to_user(line_user_id, alt_text, header_text, hero_image, item_name,
                                       contents_text, label_text, link_uri)
      toothbrush.update!(state: :end_used)
    end
  end

  desc '使用開始から3日過ぎた歯ブラシを持つユーザーにメッセージを送り、状態を更新する'
  task comment_notice_and_update: :environment do
    require 'line_message'

    Toothbrush.using_threedays.each do |toothbrush|
      line_user_id = toothbrush.user.line_user_id

      alt_text = "歯ブラシの使い心地をコメントしてみましょう！"
      header_text = "この歯ブラシを使い始めて3日が経ちました!"
      hero_image = toothbrush.item_image_urls.to_s
      item_name = toothbrush.item_name.to_s
      contents_text = "使ってみた感想をコメントしてみましょう！"
      label_text = "コメントを書く"
      link_uri = "https://www.haburashi-life.com/toothbrushes/#{toothbrush.id}/edit"

      if toothbrush.comment_notice == 'false' # rubocop:disable Style/Next
        LineMessage.send_message_to_user(line_user_id, alt_text, header_text, hero_image, item_name,
                                         contents_text, label_text, link_uri)
        toothbrush.update!(comment_notice: 'true')
      end
    end
  end

  desc '使用開始前の歯ブラシを持つユーザーにメッセージを送る'
  task notice_not_started: :environment do
    require 'line_message'

    Toothbrush.not_started.each do |toothbrush|
      line_user_id = toothbrush.user.line_user_id

      alt_text = "使用開始前の歯ブラシがあります"
      header_text = "この歯ブラシはまだ使用開始前です。"
      hero_image = toothbrush.item_image_urls.to_s
      item_name = toothbrush.item_name.to_s
      contents_text = "歯ブラシを使用する場合は、使用開始ボタンをクリックしましょう！"
      label_text = "歯ブラシを使い始める"
      link_uri = "https://www.haburashi-life.com/toothbrushes/#{toothbrush.id}/edit"

      LineMessage.send_message_to_user(line_user_id, alt_text, header_text, hero_image, item_name,
                                         contents_text, label_text, link_uri)
    end
  end
end
