class UsersController < ApplicationController
  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to toothbrushes_path, success: "ユーザー名を更新しました"
    else
      flash.now[:danger] = "更新できませんでした"
      render :edit
    end
  end

  def user_params
    params.require(:user).permit(:name)
  end
end
