module RakutenSearch
  extend ActiveSupport::Concern

  def search_results
    @results = []
    genre_ids.each do |genre_id|
      results = RakutenWebService::Ichiba::Item.search(keyword: params[:keyword], genreId: genre_id).to_a
      @results.concat(results)
    end
    @results
  end

  def paginate_results
    Kaminari.paginate_array(@results.to_a).page(params[:page])
  end
end
