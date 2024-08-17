module ApplicationHelper
  def default_meta_tags
    {
      site: '歯ブラシLife!',
      title: '歯ブラシの情報共有アプリ',
      reverse: true,
      charset: 'utf-8',
      description: '使っている歯ブラシの情報を共有し合うことで、新しい歯ブラシを探せます',
      keywords: '歯ブラシ,デンタルケア,歯ブラシのリサイクル',
      canonical: request.original_url,
      separator: '|',
      icon: [
        { href: image_url('logo.png') },
        { href: image_url('ogp_image.png'), rel: 'apple-touch-icon', sizes: '180x180', type: 'image/png' },
      ],
      og: {
        site_name: :site,
        title: :title,
        description: :description,
        type: 'website',
        url: request.original_url,
        image: image_url('ogp_image.png'),
        local: 'ja-JP',
      },
      twitter: {
        card: 'summary_large_image' # summaryかsummary_large_imageでサイズ選択
      }
    }
  end

  def not_guest_user
    if current_user.line_user_id == 'guest_user'
      true
    else
      false
    end
  end

end
