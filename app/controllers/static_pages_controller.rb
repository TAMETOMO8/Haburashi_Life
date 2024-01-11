class StaticPagesController < ApplicationController
  before_action :require_login, only: %i[user_show_from_richmenu]
  before_action :skip_login, only: %i[user_show_from_richmenu]
  def top; end

  def tutorial; end

  def user_show_from_richmenu; end
end
