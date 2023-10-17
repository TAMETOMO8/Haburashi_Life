module LineMessage
  extend self

  def send_message_to_user(line_user_id, message_text)
    require 'line/bot'
    client = Line::Bot::Client.new { |config|
      config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
      config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
    }

    message = {
      type: 'text',
      text: message_text
    }

    response = client.push_message(line_user_id, message)
    p response
  end
end
