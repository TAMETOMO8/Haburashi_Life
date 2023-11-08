class DentalItemsController < ApplicationController
  include RakutenSearch
  before_action :set_toothbrush, only: %i[new create]

  def search; end

  def new
    if params[:keyword].blank?
      redirect_to "/toothbrush/#{@toothbrush.id}/dental_item/search", warning: '検索ワードを入力してください'
    else
      @results = search_results
      @results = paginate_results
    end
  end

  def create
    @dental_item = current_user.dental_items.new(rakuten_params.merge(toothbrush_id: @toothbrush.id))
    if current_user.registered?(@dental_item)
      redirect_to new_toothbrush_dental_item_path, status: :unprocessable_entity, danger: 'すでに登録されています'
    else
      @dental_item.save!
      redirect_to toothbrush_path(@dental_item.toothbrush_id), success: 'デンタルグッズの登録が行われました！'
    end
  end

  private

  def rakuten_params
    { item_code: params[:code], item_name: params[:name], item_url: params[:url],
      item_image_urls: params[:image], item_genre_id: params[:genre_id] }
  end

  def genre_ids
    %w[204759 208265 208218 204758 208217 204760	204761 208216 402787 506388]
    # 左から 歯磨き粉 マウスウォッシュ・洗口液 デンタルフロス 歯間ブラシ 舌クリーナー・タンクリーナー ヤニ取り 口臭予防 入れ歯洗浄剤 入れ歯安定剤 ワンタフトブラシ
  end

  def set_toothbrush
    @toothbrush = Toothbrush.find(params[:toothbrush_id])
  end
end
