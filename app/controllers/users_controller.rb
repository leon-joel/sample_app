class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)   # Rails4.0ではエラーになるようになった ActiveModel::ForbiddenAttributesError
    if @user.save
      # 保存成功の場合
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end


  private 
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
