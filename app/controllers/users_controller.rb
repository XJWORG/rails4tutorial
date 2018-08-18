class UsersController < ApplicationController

  def new
    @user = User.new
  end  
    
  def create
    @user = User.new(user_params)
    if @user.save
        sign_in @user
        flash[:success] = "Welcome to Sample App !"
        redirect_to @user
    else
        render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name , :email , :password , :password_confirmation)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      # to do handle a successful udapte
    else
      render "edit"
    end
  end

end
