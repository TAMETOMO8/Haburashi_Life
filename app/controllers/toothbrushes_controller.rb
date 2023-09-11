class ToothbrushesController < ApplicationController
  def search
    if params[:keyword]
      @toothbrushes = RakutenWebService::Ichiba::Item.search(keyword: params[:keyword])
    end
  end
end
