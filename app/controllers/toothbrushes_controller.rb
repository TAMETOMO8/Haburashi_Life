class ToothbrushesController < ApplicationController
  def new
    if params[:keyword]
      @results = RakutenWebService::Ichiba::Item.search(keyword: params[:keyword], genreId: '506385')
    end
  end

  def create
    @toothbrush = current_user.toothbrushes.new(item_code: params[:code],
                                 item_name: params[:name],
                                 item_url: params[:url],
                                 item_image_urls: params[:image])
    if current_user.registered?(@toothbrush)
      flash.now[:danger] = 'すでに登録されています'
      render :new, status: :unprocessable_entity
    else
      @toothbrush.save!
      redirect_to after_login_path
    end
  end

  #  genreId: '階層3: ジャンルID:551691・・・歯ブラシ、虫歯ケア', '階層4: ID:568329・・・キッズ用歯ブラシ', 
  # '階層4: ベビー用歯ブラシ ID:551692', '階層4: 仕上げみがき用歯ブラシ	ID:551693'
  # 階層1	家電	ID:562637	2	美容・健康家電	100191	3	デンタルケア	566891	4	電動歯ブラシ	208522
  # 1	ダイエット・健康	100938	2	デンタルケア	204745									
  #1	ダイエット・健康	 100938	2	デンタルケア	204745	3	歯ブラシ	506384						
  #1	ダイエット・健康	 100938	2	デンタルケア	204745	3	歯ブラシ	506384	4	手用歯ブラシ	506385			
  #1	ダイエット・健康	 100938	2	デンタルケア	204745	3	歯ブラシ	506384	4	電子歯ブラシ・イオン歯ブラシ	506386			
  #1	ダイエット・健康	 100938	2	デンタルケア	204745	3	歯ブラシ	506384	4	360度歯ブラシ	506387			
  #1	ダイエット・健康	 100938	2	デンタルケア	204745	3	歯ブラシ	506384	4	ワンタフトブラシ	506388			
  #1	ダイエット・健康	 100938	2	デンタルケア	204745	3	歯ブラシ	506384	4	矯正用ブラシ	506389			
  #1	ダイエット・健康	 100938	2	デンタルケア	204745	3	歯ブラシ	506384	4	その他	204756

  private

  def toothbrush_params
    params.require(:toothbrush).permit(:item_code, :item_name, :item_url, item_image_url: [])
  end
end
