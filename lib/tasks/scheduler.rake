namespace :line_message do
  desc '使用終了日を過ぎた歯ブラシを持つユーザーにメッセージを送り、状態を更新する'
  task push_message_and_update: :environment do
    require 'line_message'

    Toothbrush.end_toothbrushed.each do |toothbrush|
      user = toothbrush.user
      line_user_id = user.line_user_id

      recycling_url = "https://www.lion.co.jp/ja/sustainability/toothbrush-recycling/"
      edit_url = "https://2a4c-126-227-254-194.ngrok-free.app/toothbrushes/#{toothbrush.id}/edit"

      message_text = "次の歯ブラシを交換する時が来ました・・・\n\n#{toothbrush.item_name}\n
      ところで、歯ブラシはリサイクルが可能なことをご存知でしょうか?歯ブラシのリサイクルで地球環境の改善に繋がりますので、ぜひこの機会にリサイクルしてみてください!
      \nリサイクルプログラムのページ:#{recycling_url}\nまたは、掃除道具として使うことで部屋の環境を改善するのもいいですね!
      \nそれでは、このページから歯ブラシをどうするか決めましょう!\n#{edit_url}"
      LineMessage.send_message_to_user(line_user_id, message_text)
      toothbrush.update!(state: :end_used)
    end
  end
end