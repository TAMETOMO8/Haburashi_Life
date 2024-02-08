namespace :line_message do # rubocop:disable Metrics/BlockLength
  desc '使用終了日を過ぎた歯ブラシを持つユーザーにメッセージを送り、状態を更新する'
  task push_message_and_update: :environment do
    require 'line_message'

    Toothbrush.end_toothbrushed.each do |toothbrush|
      user = toothbrush.user
      line_user_id = user.line_user_id

      edit_url = "https://www.haburashi-life.com/toothbrushes/#{toothbrush.id}/edit"

      message_text = "歯ブラシの交換のお知らせです！\n\n#{toothbrush.item_name}\n
      使い終わったあとはどうするか、次のURLから決めましょう！\n#{edit_url}"

      LineMessage.send_message_to_user(line_user_id, message_text)
      toothbrush.update!(state: :end_used)
    end
  end

  desc '使用開始から3日過ぎた歯ブラシを持つユーザーにメッセージを送り、状態を更新する'
  task comment_notice_and_update: :environment do
    require 'line_message'

    Toothbrush.using_threedays.each do |toothbrush|
      user = toothbrush.user
      line_user_id = user.line_user_id

      edit_url = "https://www.haburashi-life.com/toothbrushes/#{toothbrush.id}/edit"

      message_text = "次の歯ブラシを使い始めて3日が経ちました!\n\n#{toothbrush.item_name}\n
      もしよろしければ、使ってみた感想をコメントしてみてください！
      \n\n\n編集ページに移動する\n#{edit_url}"

      if toothbrush.comment_notice == 'false'
        LineMessage.send_message_to_user(line_user_id, message_text)
        toothbrush.update!(comment_notice: 'true')
      end
    end
  end
end
