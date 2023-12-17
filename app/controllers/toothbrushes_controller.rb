class ToothbrushesController < ApplicationController
  include RakutenSearch #controllers/concerns/rakuten_search.rb
  require 'line_message'
  before_action :require_login, only: %i[edit new search]
  before_action :set_toothbrush, only: %i[show edit update update_state]

  def index
    @toothbrushes = if logged_in?
                      Toothbrush.includes(:user).where.not(user: current_user).order(created_at: :desc)
                    else
                      Toothbrush.includes(:user).order(created_at: :desc)
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
      register_message
      redirect_to edit_toothbrush_path(@toothbrush), success: '歯ブラシが選択されました！続けてブラシの素材、やわらかさ、使い終わる日を決めましょう！'
    end
  end

  def update
    if @toothbrush.update(toothbrush_params)
      start_used
      redirect_to user_path(current_user), success: '登録されました！'
    else
      flash.now[:danger] = '登録されませんでした'
      render :edit
    end
  end

  def update_state
    new_state = params[:new_state]

    if @toothbrush.end_used? && new_state.in?(%w[cleaning recycling])
      @toothbrush.update(state: new_state)
      redirect_to toothbrushes_path, success: '歯ブラシの状態を更新しました！'
    else
      flash[:danger] = '歯ブラシの状態を更新できませんでした'
      redirect_to toothbrushes_path
    end
  end

  private

  def set_toothbrush
    @toothbrush = Toothbrush.find(params[:id])
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
    message_text = "新しい歯ブラシが登録されました!大切に使ってあげてください!\n歯ブラシの使用終了日を決めると、終了日が来た際にお知らせいたしますのでお待ちください!"
    LineMessage.send_message_to_user(line_user_id, message_text)
  end
end
