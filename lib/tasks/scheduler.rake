namespace :line_message do # rubocop:disable Metrics/BlockLength
  desc '使用終了日を過ぎた歯ブラシを持つユーザーにメッセージを送り、状態を更新する'
  task push_message_and_update: :environment do
    require 'line_message'

    Toothbrush.end_toothbrushed.each do |toothbrush|
      user = toothbrush.user
      line_user_id = user.line_user_id

      recycling_url = 'https://www.lion.co.jp/ja/sustainability/toothbrush-recycling/'
      edit_url = "https://www.haburashi-life.com/toothbrushes/#{toothbrush.id}/edit"

      message_text = "次の歯ブラシを交換する時が来ました・・・\n\n#{toothbrush.item_name}\n
      ところで、歯ブラシはリサイクルが可能なことをご存知でしょうか?歯ブラシのリサイクルで地球環境の改善に繋がりますので、ぜひこの機会にリサイクルしてみてください!
      \nリサイクルプログラムのページ:#{recycling_url}\nまたは、掃除道具として使うことで部屋の環境を改善するのもいいですね!
      \nそれでは、このページから歯ブラシをどうするか決めましょう!\n#{edit_url}"

      LineMessage.send_message_to_user(line_user_id, message_text)
      toothbrush.update!(state: :end_used)
    end
  end

  desc '使用開始から5日過ぎた歯ブラシを持つユーザーにメッセージを送り、状態を更新する'
  task comment_notice_and_update: :environment do
    require 'line_message'

    Toothbrush.using_fivedays.each do |toothbrush|
      user = toothbrush.user
      line_user_id = user.line_user_id

      edit_url = "https://www.haburashi-life/toothbrushes/#{toothbrush.id}/edit"

      message_text = "次の歯ブラシを登録して5日が経ちました!\n\n#{toothbrush.item_name}\n
      もしよろしければこのページに移動して、使ってみた感想をコメントしてみてください！\n#{edit_url}"

      if toothbrush.comment_notice == 'false'
        LineMessage.send_message_to_user(line_user_id, message_text)
        toothbrush.update!(comment_notice: 'true')
      end
    end
  end
end
