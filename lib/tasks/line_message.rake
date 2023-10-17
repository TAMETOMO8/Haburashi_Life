namespace :line_message do
  desc "タスクの通知" 
  task push_line_message: :environment do
      require 'line/bot'
      client = Line::Bot::Client.new { |config|
        config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
        config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
      }

      users = User.all
      users.each do |user|
        line_user_id = user.line_user_id

            message = {
                type: 'text',
                text: "登録ありがとうございます！"
            }
            response = client.push_message(line_user_id, message)
            p response
      end
  end
end