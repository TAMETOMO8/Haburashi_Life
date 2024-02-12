class UsersController < ApplicationController
  before_action :require_login, only: %i[edit]

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(current_user), success: 'ユーザー名を更新しました'
    else
      flash.now[:danger] = 'ユーザー名を更新できませんでした'
      render :edit, status: :unprocessable_entity
    end
  end

  def show
    @user = User.includes(:toothbrushes).find(params[:id])
    @toothbrushes = @user.toothbrushes.order(end_use_at: :asc)
  end

  private

  def user_params
    params.require(:user).permit(:name)
  end
end
