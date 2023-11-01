class ToothbrushesController < ApplicationController
  require 'line_message'
  before_action :require_login, only: %i[edit new search]

  def index
    @toothbrushes = Toothbrush.includes(:user).order(created_at: :desc)
  end

  def edit
    @toothbrush = Toothbrush.find(params[:id])
  end

  def search; end

  def new
    return unless params[:keyword]

    @results = []
    genre_ids.each do |genre_id|
      results = RakutenWebService::Ichiba::Item.search(keyword: params[:keyword], genreId: genre_id).to_a
      @results.concat(results)
    end
    @results = Kaminari.paginate_array(@results.to_a).page(params[:page])
  end

  def create
    @toothbrush = current_user.toothbrushes.new(rakuten_params)
    if current_user.registered?(@toothbrush)
      redirect_to new_toothbrush_path, status: :unprocessable_entity, danger: 'すでに登録されています'
    else
      @toothbrush.save!
      register_message
      redirect_to edit_toothbrush_path(@toothbrush), success: '歯ブラシが選択されました！続けてブラシの素材、やわらかさ、使い終わる日を決めましょう！'
    end
  end

  def update
    @toothbrush = Toothbrush.find(params[:id])
    if @toothbrush.update(toothbrush_params)
      start_used
      redirect_to toothbrushes_path, success: '登録されました！'
    else
      flash.now[:danger] = t('defaults.message.not_updated', item: Toothbrush.model_name.human)
      render :edit
    end
  end

  def after_used
    @user = User.find(params[:id])
    @toothbrush = Toothbrush.find(params[:id])
  end

  private

  def genre_ids
    %w[506385 506386 506387 506389 568329 551692 551693 208522]
  end

  def rakuten_params
    { item_code: params[:code], item_name: params[:name], item_url: params[:url], item_image_urls: params[:image] }
  end

  def toothbrush_params
    params.require(:toothbrush).permit(:end_use_at, :brush_material, :hardness, :state)
  end

  def start_used
    @toothbrush.not_started? ? @toothbrush.update(state: 1) : nil
  end

  def register_message
    line_user_id = current_user.line_user_id
    message_text = "新しい歯ブラシが登録されました!\n大切に使ってあげてください!"
    LineMessage.send_message_to_user(line_user_id, message_text)
  end
end
