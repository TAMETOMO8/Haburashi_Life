class ToothbrushesController < ApplicationController
  include RakutenSearch #controllers/concerns/rakuten_search.rb
  include ToothbrushesHelper
  require 'line_message'
  before_action :require_login, only: %i[edit new search]
  before_action :set_toothbrush, only: %i[show edit update update_state]

  def index # rubocop:disable Metrics/AbcSize
    @q = Toothbrush.ransack(params[:q])
    @toothbrushes = if logged_in?
                      @q.result(distinct: true).includes(:user)
                        .where.not(user: current_user).order(created_at: :desc).page(params[:page]).per(12)
                    else
                      @q.result(distinct: true).includes(:user).order(created_at: :desc).page(params[:page]).per(12)
                    end
  end

  def show
    @dental_items = @toothbrush.dental_items.to_a
  end

  def edit; end

  def search; end

  def new
    if params[:keyword].blank?
      redirect_to toothbrush_search_path, warning: '検索ワードを入力してください'
    else
      @results = search_results
      @results = paginate_results
    end
  end

  def create
    @toothbrush = current_user.toothbrushes.new(rakuten_params)
    if current_user.registered?(@toothbrush)
      redirect_to new_toothbrush_path, status: :unprocessable_entity, danger: 'すでに登録されています'
    else
      @toothbrush.save!
      push_register_message
      redirect_to edit_toothbrush_path(@toothbrush), success: '歯ブラシが選択されました！続けてブラシの素材、やわらかさ、使い終わる日を決めましょう！'
    end
  end

  def update
    check_blank
    if @toothbrush.update(toothbrush_params)
      start_used
      redirect_to toothbrush_path(@toothbrush), success: '内容が登録されました！'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @toothbrush = current_user.toothbrushes.find(params[:id])
    @toothbrush.destroy!
    redirect_to user_path(current_user), success: '歯ブラシを削除しました'
  end

  def update_state
    new_state = params[:new_state]
    if @toothbrush.end_used? && new_state.in?(%w[cleaning recycling]) || @toothbrush.cleaning? && new_state.in?(%w[recycling]) # rubocop:disable Layout/LineLength
      @toothbrush.update!(state: new_state)
      redirect_to environment_path, success: 'あなたのおかげで環境が整いました!ご協力ありがとうございます!'
    elsif new_state.in?(%w[end_used])
      @toothbrush.end_use_at = Time.current
      @toothbrush.update!(state: new_state)
      push_end_used_message
      redirect_to toothbrush_path(@toothbrush), success: '歯ブラシを使い終わりました!'
    end
  end

  def index_search
    @toothbrush = Toothbrush.where('item_name like ?', "%#{params[:q]}%")
    respond_to(&:js)
  end

  private

  def set_toothbrush
    @toothbrush = Toothbrush.find(params[:id])
  end

  def rakuten_params
    { item_code: params[:code], item_name: params[:name], item_url: params[:url], item_image_urls: params[:image] }
  end

  def toothbrush_params
    params.require(:toothbrush).permit(:end_use_at, :brush_material, :hardness, :state, :comment)
  end

  def start_used
    @toothbrush.not_started? ? @toothbrush.update(state: 1) : nil
  end

  def check_blank
    params[:toothbrush][:comment] = '' if params[:toothbrush][:comment].blank?
  end

  def push_register_message
    line_user_id = current_user.line_user_id
    alt_text = "新しい歯ブラシが登録されました！"
    header_text = "新しい歯ブラシの登録です!"
    hero_image = @toothbrush.item_image_urls.to_s
    item_name = @toothbrush.item_name.to_s
    contents_text = "歯ブラシの使用終了日を決めると、終了日が来た際にお知らせいたします!"
    label_text = "歯ブラシの設定を確認する"
    link_uri = "https://www.haburashi-life.com#{edit_toothbrush_path(@toothbrush)}"
    LineMessage.send_message_to_user(line_user_id, alt_text, header_text, hero_image, item_name,
                                     contents_text, label_text, link_uri)
  end

  def push_end_used_message
    line_user_id = current_user.line_user_id
    alt_text = "歯ブラシを使い終わりました"
    header_text = "次の歯ブラシを使い終わりました"
    hero_image = @toothbrush.item_image_urls.to_s
    item_name = @toothbrush.item_name.to_s
    link_uri = "https://www.haburashi-life.com#{@toothbrush.id}"
    if @toothbrush.electric?
      contents_text = "電動歯ブラシの処理は、各自治体の決まりに従いましょう!"
      label_text = "歯ブラシの詳細を確認する"
    else
      contents_text = "掃除道具として使うのか、それともリサイクルするのか、決めましょう！"
      label_text = "使い終わった後を決める"
    end
    LineMessage.send_message_to_user(line_user_id, alt_text, header_text, hero_image, item_name,
                                     contents_text, label_text, link_uri)
  end
end
