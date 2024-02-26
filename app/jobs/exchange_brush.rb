class ExchangeBrushJob < ApplicationJob
  queue_as :default

  def perform(toothbrush)
    # Do something later
    toothbrush = Toothbrush.find(toothbrush)
    line_user_id = toothbrush.user.line_user_id

    alt_text = "交換日が来た歯ブラシがあります"
    header_text = "歯ブラシの交換のお知らせです！"
    hero_image = toothbrush.item_image_urls.to_s
    item_name = toothbrush.item_name.to_s
    contents_text = "使い終わったあとはどうするかを決めましょう！"
    label_text = "使い方を決める"
    link_uri = "https://www.haburashi-life.com/toothbrushes/#{toothbrush_id}"

    LineMessage.send_message_to_user(line_user_id, alt_text, header_text, hero_image, item_name,
                                     contents_text, label_text, link_uri)
    toothbrush.update!(state: :end_used)
  end
end
