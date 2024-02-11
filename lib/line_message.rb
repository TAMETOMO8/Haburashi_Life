module LineMessage
  module_function

  def send_message_to_user(line_user_id, alt_text, header_text, hero_image, item_name,
    contents_text, label_text, link_uri)
    require 'line/bot'
    client = Line::Bot::Client.new do |config|
      config.channel_secret = ENV['LINE_CHANNEL_SECRET']
      config.channel_token = ENV['LINE_CHANNEL_TOKEN']
    end

    flex_message = {
      "type": "flex",
      "altText": alt_text,
      "contents": {
        "type": "bubble",
        "header": {
          "type": "box",
          "layout": "vertical",
          "contents": [
            {
              "type": "text",
              "weight": "bold",
              "text": header_text,
              "size": "lg",
              "wrap": true
            }
          ],
          "alignItems": "center"
        },
        "hero": {
          "type": "image",
          "url": hero_image,
          "size": "full"
        },
        "body": {
          "type": "box",
          "layout": "vertical",
          "contents": [
            {
              "type": "text",
              "text": item_name,
              "wrap": true,
              "size": "sm",
              "weight": "bold"
            },
            {
              "type": "text",
              "text": contents_text,
              "wrap": true,
              "margin": "md"
            }
          ]
        },
        "footer": {
          "type": "box",
          "layout": "vertical",
          "contents": [
            {
              "type": "button",
              "action": {
                "type": "uri",
                "label": label_text,
                "uri": link_uri
              }
            }
          ]
        },
        "styles": {
          "hero": {
            "separator": true
          },
          "footer": {
            "separator": true
          }
        }
      }
    }

    response = client.push_message(line_user_id, flex_message)
    p response
  end
end
