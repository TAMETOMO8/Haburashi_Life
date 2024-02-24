class Toothbrush < ApplicationRecord
  belongs_to :user
  has_many :dental_items, dependent: :destroy

  validates :user_id, presence: true
  validates :comment, length: { maximum: 100 }

  enum state: { not_started: 0, using: 1, end_used: 2, cleaning: 3, recycling: 4 }
  enum brush_material: { nylon_hair: 0, animal_hair: 1, electric: 2, other: 3 }
  enum hardness: { normal: 0, soft: 1, hard: 2 }

  def self.ransackable_attributes(_auth_object = nil)
    %w[item_name]
  end

  scope :end_toothbrushed, -> { using.where('end_use_at <= ?', Time.current) }
  scope :used, -> { where.not(state: :not_started) }
  scope :using_threedays, -> { used.where('created_at <= ?', Time.current - 3.days) }

  def exchange_brush # rubocop:disable Metrics/MethodLength
    line_user_id = toothbrush.user.line_user_id

    alt_text = "交換日が来た歯ブラシがあります"
    header_text = "歯ブラシの交換のお知らせです！"
    hero_image = toothbrush.item_image_urls.to_s
    item_name = toothbrush.item_name.to_s
    contents_text = "使い終わったあとはどうするかを決めましょう！"
    label_text = "使い方を決める"
    link_uri = "https://www.haburashi-life.com/toothbrushes/#{toothbrush.id}"

    LineMessage.send_message_to_user(line_user_id, alt_text, header_text, hero_image, item_name,
                                      contents_text, label_text, link_uri)
    toothbrush.update!(state: :end_used)
  end

  def comment_notice_and_update # rubocop:disable Metrics/MethodLength,Metrics/AbcSize
    line_user_id = toothbrush.user.line_user_id

    alt_text = "歯ブラシの使い心地をコメントしてみましょう！"
    header_text = "この歯ブラシを使い始めて3日が経ちました!"
    hero_image = toothbrush.item_image_urls.to_s
    item_name = toothbrush.item_name.to_s
    contents_text = "使ってみた感想をコメントしてみましょう！"
    label_text = "コメントを書く"
    link_uri = "https://www.haburashi-life.com/toothbrushes/#{toothbrush.id}/edit"

    return unless toothbrush.comment_notice == 'false' # rubocop:disable Style/Next,Lint/RedundantCopDisableDirective

    LineMessage.send_message_to_user(line_user_id, alt_text, header_text, hero_image, item_name,
                                     contents_text, label_text, link_uri)
    toothbrush.update!(comment_notice: 'true')
  end

  def notice_not_started # rubocop:disable Metrics/MethodLength,Lint/RedundantCopDisableDirective
    line_user_id = toothbrush.user.line_user_id

    alt_text = "使用開始前の歯ブラシがあります"
    header_text = "この歯ブラシはまだ使用開始前です。"
    hero_image = toothbrush.item_image_urls.to_s
    item_name = toothbrush.item_name.to_s
    contents_text = "歯ブラシを使用する場合は、使用開始ボタンをクリックしましょう！"
    label_text = "歯ブラシを使い始める"
    link_uri = "https://www.haburashi-life.com/toothbrushes/#{toothbrush.id}/edit"

    LineMessage.send_message_to_user(line_user_id, alt_text, header_text, hero_image, item_name,
                                     contents_text, label_text, link_uri)
  end

  def push_line_message
    if end_toothbrushed?
      ExchangeBlushJob.set(wait_until: end_toothbrushed).perform_later(self)
    elsif using_threedays?
      CommentNoticeJob.set(wait_until: using_threedays).perform_later(self)
    elsif not_started?
      NoticeNotStartedJob.set(wait_until: 1.days).perform_later(self)
    end
  end
end
