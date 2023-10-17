namespace :line_message do
  desc "タスクの通知" 
  task push_line_message: :environment do
    require 'line/bot'
    require 'line_message'
    client = Line::Bot::Client.new { |config|
      config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
      config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
    }

    users = User.all
    users.each do |user|
      line_user_id = user.line_user_id
      message_text = "使い心地はいかがでしょうか？"

      LineMessage.send_message_to_user(line_user_id, message_text)
    end
  end
end