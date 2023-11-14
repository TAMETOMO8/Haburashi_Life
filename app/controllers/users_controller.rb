class UsersController < ApplicationController
  before_action :require_login, only: %i[edit]

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to toothbrushes_path, success: 'ユーザー名を更新しました'
    else
      flash.now[:notice] = 'ユーザー名を更新できませんでした'
      render :edit
    end
  end

  def show
    @user = User.includes(:toothbrushes).find(params[:id])
    @toothbrush = @user.toothbrushes.find(params[:user_id])
  end

  private

  def user_params
    params.require(:user).permit(:name)
  end
end
