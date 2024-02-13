class TopPagesController < ApplicationController
  before_action :require_login, only: %i[user_show_from_richmenu]
  before_action :skip_login, only: %i[user_show_from_richmenu]
  def top
    @toothbrush = Toothbrush.all
  end

  def tutorial; end

  def user_show_from_richmenu; end

  def terms; end

  def privacy_policy; end
end
