class UsersController < ApplicationController
  before_action :authenticate_user!
  
  load_and_authorize_resource

  def index
    @user = User.all
  end

 
  def show
      @user = User.find(params[:id])
      @users = User.all
      
    end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to(@user)
  end


  # DELETE /users/:id
  def destroy
    @user.destroy
    respond_with(@user)
  end


  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:email, :nickname, :first_name, :last_name, :name, :image, :urls, :location, :verified, :gender, :postcode, :home_lat, :home_long, :description, :provider, :uid)
    end

end
