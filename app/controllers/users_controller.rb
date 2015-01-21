class UsersController < ApplicationController


  authorize_resource

  def index
    @users = User.all
    respond_to do |format|
      format.html
      format.json { render json: @users, root: false }
    end
  end

  def show
    @user = User.find(params[:id])
   
  end

  def edit
   @user = current_user
  end

  def update
    current_user.update(user_params)
    redirect_to(user_path(current_user))
  end

  private

  def user_params
    params.require(:user).permit(:email, :nickname, :first_name, :last_name, :name, :image, :remote_image_url, :urls, :location, :verified, :gender, :postcode, :description)
  end

end
