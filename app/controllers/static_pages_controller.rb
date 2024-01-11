class StaticPagesController < ApplicationController
  before_action :require_login, only: %i[richmenu_login]
  before_action :skip_login, only: %i[richmenu_login]
  def top; end

  def tutorial; end

  def richmenu_login; end
end
