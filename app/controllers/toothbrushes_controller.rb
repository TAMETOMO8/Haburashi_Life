class ToothbrushesController < ApplicationController
  require 'line_message'

  def index
    @toothbrushes = Toothbrush.includes(:user).order(created_at: :desc)
  end

  def new
    return unless params[:keyword]

    genre_ids = %w[506385 506386 506387 506389 568329 551692 551693 208522]
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
      flash.now[:danger] = 'すでに登録されています'
      render :new, status: :unprocessable_entity
    else
      @toothbrush.save!
      register_message
      redirect_to after_login_path
    end
  end

  private

  def rakuten_params
    { item_code: params[:code], item_name: params[:name], item_url: params[:url], item_image_urls: params[:image] }
  end

  def register_message
    line_user_id = current_user.line_user_id
    message_text = '登録ありがとうございます！'
    LineMessage.send_message_to_user(line_user_id, message_text)
  end
end
