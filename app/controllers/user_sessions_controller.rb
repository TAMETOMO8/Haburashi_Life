class UserSessionsController < ApplicationController
  before_action :skip_login, only: %i[login callback]
  require 'json'
  require 'typhoeus'
  require 'securerandom'

  def login
    # CSRF(クロスサイトリクエストフォージュリ)・・・JavaScriptなどを用いてリクエストを偽造(フォージュリ)した不正アクセス
    # CSRFの対策に固有な英数字の文字列を作成してURLに組み込み、ログインセッションごとにWebアプリでランダムに文字列を生成する
    # これによりURLを偽造した不正アクセスによるサイバー攻撃に対処ができる
    session[:state] = SecureRandom.urlsafe_base64

    # ユーザーに認証と認可を要求するページに移動するURLを形成
    client_id = ENV['LINE_KEY']
    redirect_uri = CGI.escape(user_sessions_callback_url)
    state = session[:state]

    authorization_url = "https://access.line.me/oauth2/v2.1/authorize?response_type=code&client_id=#{client_id}&redirect_uri=#{redirect_uri}&state=#{state}&scope=profile%20openid"

    redirect_to authorization_url, allow_other_host: true
  end

  def callback
    return redirect_to root_path, danger: '不正なアクセスです' if invalid_access?

    user = find_or_initialize_user
    if user.save
      session[:user_id] = user.id
      redirect_to toothbrush_search_path, success: 'ログインしました! '
    else
      redirect_to root_path, danger: 'ログインに失敗しました'
    end
  end

  def destroy
    reset_session
    redirect_to root_path, success: 'ログアウトしました'
  end

  def guest_login
    if logged_in?
      redirect_to toothbrush_search_path, warning: 'すでにログインしています'
    else
      session[:user_id] = User.find_by(name: 'ゲストユーザー').id
      redirect_to toothbrush_search_path, success: 'ゲストユーザーとしてログインしました'
    end
  end

  private

  def invalid_access?
    params[:state] != session[:state]
  end

  def find_or_initialize_user
    User.find_or_initialize_by(line_user_id: get_line_user_id(params[:code]))
  end

  def get_line_user_id(code)
    # ユーザーのIDトークンからプロフィール情報（ユーザーID）を取得する
    line_user_id_token = get_line_user_id_token(code)

    return nil unless line_user_id_token.present?

    url = 'https://api.line.me/oauth2/v2.1/verify'
    options = { body: { id_token: line_user_id_token, client_id: ENV['LINE_KEY'] } }
    response = Typhoeus::Request.post(url, options)

    response.code == 200 ? JSON.parse(response.body)['sub'] : nil
  end

  def get_line_user_id_token(code)
    url = 'https://api.line.me/oauth2/v2.1/token'
    redirect_uri = user_sessions_callback_url

    options = {
      headers: { 'Content-Type' => 'application/x-www-form-urlencoded' },
      body: { grant_type: 'authorization_code', code:, redirect_uri:, client_id: ENV['LINE_KEY'],
              client_secret: ENV['LINE_SECRET'] }
    }
    response = Typhoeus::Request.post(url, options)

    response.code == 200 ? JSON.parse(response.body)['id_token'] : nil
  end
end
