class UsersController < ApplicationController

before_action :set_user, only: [:show, :edit, :update]

  authorize_resource

  def index
    @users = User.all
  end


  def show
  end

  def edit
    # redirect_to edit_profile_path
  end

  def update
    @user.update(user_params)
    redirect_to(profile_path)
  end




  private
  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:email, :nickname, :first_name, :last_name, :name, :image, :urls, :location, :verified, :gender, :postcode, :home_lat, :home_long, :description)
  end

end
