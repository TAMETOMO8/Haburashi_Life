namespace :line_message do
  desc 'タスクの通知'
  task push_line_message: :environment do
    require 'line_message'

    users = User.all
    users.each do |user|
      line_user_id = user.line_user_id
      message_text = '使い心地はいかがでしょうか？'

      LineMessage.send_message_to_user(line_user_id, message_text)
    end
  end
end
