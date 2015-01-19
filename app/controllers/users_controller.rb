class UsersController < ApplicationController

before_action :set_user, only: [:show, :edit, :update]

  load_and_authorize_resource

  def index
    @users = User.all
  end


  def show
  end

  def edit
  end

  def update
    @user.update(user_params)
    redirect_to(@user)
  end




  private
  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:email, :nickname, :first_name, :last_name, :name, :image, :urls, :location, :verified, :gender, :postcode, :home_lat, :home_long, :description)
  end

end
