namespace :line_message do
  desc '使用終了日を過ぎた歯ブラシを持つユーザーにメッセージを送り、状態を更新する'
  task push_message_and_update: :environment do
    require 'line_message'

    Toothbrush.end_toothbrushed.each do |toothbrush|
      user = toothbrush.user
      line_user_id = user.line_user_id

      ROOT_URL = "https://haburashi-life-827afeb996be.herokuapp.com/"
      select_url = "#{ROOT_URL}user/#{toothbrush.user_id}/toothbrush/#{toothbrush.id}" 

      message_text = "次の歯ブラシを交換する時が来ました・・・\n\n#{toothbrush.item_name}\n\n
      この歯ブラシをどうするか、リンク先のページで決めましょう\n<a href='#{select_url}'>クリックして歯ブラシの使い方を決める</a>"
      LineMessage.send_message_to_user(line_user_id, message_text)
      toothbrush.update!(state: :end_used)
    end
  end
end
