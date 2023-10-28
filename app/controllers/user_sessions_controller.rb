class UserSessionsController < ApplicationController
  require 'json'
  require 'typhoeus'
  require 'securerandom'

  def login
    # CSRF対策用の固有な英数字の文字列を作成、ログインセッションごとにWebアプリでランダムに文字列を生成する
    session[:state] = SecureRandom.urlsafe_base64

    # ユーザーに認証と認可を要求するページに移動するURLを形成
    client_id = ENV['LINE_KEY']
    redirect_uri = CGI.escape(user_sessions_callback_url)
    state = session[:state]

    authorization_url = "https://access.line.me/oauth2/v2.1/authorize?response_type=code&client_id=#{client_id}&redirect_uri=#{redirect_uri}&state=#{state}&scope=profile%20openid"

    redirect_to authorization_url, allow_other_host: true
  end

  def callback
    # CSRF対策のトークンが一致する場合のみ、ログイン処理を行う
    return redirect_to root_path, danger: '不正なアクセスです' if params[:state] != session[:state]

    line_user_id = get_line_user_id(params[:code])
    user = User.find_or_initialize_by(line_user_id: line_user_id)

    if user.save
      session[:user_id] = user.id
      redirect_to toothbrush_search_path, success: 'ログインしました'
    else
      redirect_to root_path, danger: 'ログインに失敗しました'
    end
  end

  def destroy
    reset_session
    redirect_to root_path, notice: 'ログアウトしました'
  end

  private

  def get_line_user_id(code)
    # ユーザーのIDトークンからプロフィール情報（ユーザーID）を取得する
    line_user_id_token = get_line_user_id_token(code)

    return nil unless line_user_id_token.present?

    url = 'https://api.line.me/oauth2/v2.1/verify'
    options = {
      body: {
        id_token: line_user_id_token,
        client_id: ENV['LINE_KEY']
      }
    }

    response = Typhoeus::Request.post(url, options)

    if response.code == 200
      JSON.parse(response.body)['sub']
    else
      nil
    end
  end

  def get_line_user_id_token(code)
    # ユーザーのアクセストークン（IDトークン）を取得する
    url = 'https://api.line.me/oauth2/v2.1/token'
    redirect_uri = user_sessions_callback_url

    options = {
      headers: {
        'Content-Type' => 'application/x-www-form-urlencoded'
      },
      body: {
        grant_type: 'authorization_code',
        code: code,
        redirect_uri: redirect_uri,
        client_id: ENV['LINE_KEY'],
        client_secret: ENV['LINE_SECRET']
      }
    }

    response = Typhoeus::Request.post(url, options)

    if response.code == 200
      JSON.parse(response.body)['id_token'] # ユーザー情報を含むJSONウェブトークン（JWT）
    else
      nil
    end
  end
end
