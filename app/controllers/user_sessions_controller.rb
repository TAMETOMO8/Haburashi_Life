class UserSessionsController < ApplicationController
  require 'json'
  require 'typhoeus'
  require 'securerandom'

  def login

    # CSRF対策用の固有な英数字の文字列
    # ログインセッションごとにWebアプリでランダムに生成する
    session[:state] = SecureRandom.urlsafe_base64

    # ユーザーに認証と認可を要求する
    # https://developers.line.biz/ja/docs/line-login/integrate-line-login/#making-an-authorization-request

    base_authorization_url = 'https://access.line.me/oauth2/v2.1/authorize'
    response_type = 'code'
    client_id = ENV['LINE_KEY'] #本番環境では環境変数などに保管する
    redirect_uri = CGI.escape(user_sessions_callback_url)
    state = session[:state]
    scope = 'profile%20openid' #ユーザーに付与を依頼する権限、詳細はAPIのドキュメント参照

    authorization_url = "#{base_authorization_url}?response_type=#{response_type}&client_id=#{client_id}&redirect_uri=#{redirect_uri}&state=#{state}&scope=#{scope}"

    redirect_to authorization_url, allow_other_host: true
  end

  def callback

    # CSRF対策のトークンが一致する場合のみ、ログイン処理を続ける
    if params[:state] == session[:state]

      line_user_id = get_line_user_id(params[:code])
      user = User.find_or_initialize_by(line_user_id: line_user_id)

      if user.save
        session[:user_id] = user.id
        redirect_to after_login_path, notice: 'ログインしました'
      else
        redirect_to root_path, notice: 'ログインに失敗しました'
      end

    else
      redirect_to root_path, notice: '不正なアクセスです'
    end

  end

  def destroy
    reset_session
    redirect_to root_path, notice: 'ログアウトしました'
  end

  private

  def get_line_user_id(code)

    # ユーザーのIDトークンからプロフィール情報（ユーザーID）を取得する
    # https://developers.line.biz/ja/docs/line-login/verify-id-token/

    line_user_id_token = get_line_user_id_token(code)

    if line_user_id_token.present?

      url = 'https://api.line.me/oauth2/v2.1/verify'
      options = {
        body: {
          id_token: line_user_id_token,
          client_id: ENV['LINE_KEY'] # 本番環境では環境変数などに保管
        }
      }

      response = Typhoeus::Request.post(url, options)

      if response.code == 200
        JSON.parse(response.body)['sub']
      else
        nil
      end
    
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
        client_id: ENV['LINE_KEY'], # 本番環境では環境変数などに保管
        client_secret: ENV['LINE_SECRET'] # 本番環境では環境変数などに保管
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
