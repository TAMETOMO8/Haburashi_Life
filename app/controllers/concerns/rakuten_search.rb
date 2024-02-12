module RakutenSearch
  extend ActiveSupport::Concern

  included do
    before_action :set_genre_ids
  end

  def search_results
    @results = []
    @genre_ids.each do |genre_id|
      results = RakutenWebService::Ichiba::Item.search(keyword: params[:keyword], genreId: genre_id,
                                                       NGKeyword: @ng_keywords.join(' ')).to_a
      @results.concat(results)
    end
    @results
  end

  def paginate_results
    Kaminari.paginate_array(@results.to_a).page(params[:page])
  end

  private

  def set_genre_ids
    if self.is_a?(ToothbrushesController)
      @genre_ids = toothbrushes_genre_ids
      @ng_keywords = %w[セール アソート クーポン 送料 メール便 倍 納期 どれか デンタルジェル 替えブラシ 替ブラシ シェーバー 最安値 セット]
    elsif self.is_a?(DentalItemsController)
      @genre_ids = dental_items_genre_ids
      @ng_keywords = %w[セール アソート クーポン 送料 メール便 倍 納期 どれか 最安値 セット]
    end
  end

  def toothbrushes_genre_ids
    %w[506385 506386 506387 506389 568329 551692 551693 208522]

    # 左から 手用歯ブラシ 電子歯ブラシ・イオン歯ブラシ 360度歯ブラシ 矯正用ブラシ キッズ用歯ブラシ ベビー用歯ブラシ 仕上げみがき用歯ブラシ 電動歯ブラシ
  end

  def dental_items_genre_ids
    %w[204759 208265 208218 204758 208217 204760 204761 208216 402787 506388]

    # 左から 歯磨き粉 マウスウォッシュ・洗口液 デンタルフロス 歯間ブラシ 舌クリーナー・タンクリーナー ヤニ取り 口臭予防 入れ歯洗浄剤 入れ歯安定剤 ワンタフトブラシ
  end
end
