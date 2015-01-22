class DogsController < ApplicationController
  before_action :set_dog, only: [:show, :edit, :update, :destroy]

  load_and_authorize_resource
  
  respond_to :html

  def index

    @q = Dog.ransack(params[:q])
    @dogs = @q.result(distinct: true)
  
  end

  def show
    @q = Dog.ransack(params[:q])
    @dogs = @q.result(distinct: true)
    respond_with(@dog)
  end

  def new
    @q = Dog.ransack(params[:q])
    @dogs = @q.result(distinct: true)
    @dog = Dog.new
    @dog.user_id = params[:user_id].to_i
    respond_with(@dog)
  end

  def edit
    @q = Dog.ransack(params[:q])
    @dogs = @q.result(distinct: true)
  end

  def create
    @q = Dog.ransack(params[:q])
    @dogs = @q.result(distinct: true)
    @dog = Dog.new(dog_params)
    @dog.save
    respond_with(@dog)
  end

  def update
    @q = Dog.ransack(params[:q])
    @dogs = @q.result(distinct: true)
    @dog.update(dog_params)
    respond_with(@dog)
  end

  def destroy
    @q = Dog.ransack(params[:q])
    @dogs = @q.result(distinct: true)
    @dog.destroy
    respond_with(@dog)
  end

  def like
    @dog.like_by current_user
    redirect_to dog_path(@dog)
  end

  def unlike
    @dog.unliked_by current_user
    redirect_to dog_path(@dog)
  end

  def dogs_most_voted
    @dogs = Dog.get_likes.size
    raise
  end

  private
    def set_dog
      @dog = Dog.find(params[:id])
    end

    def dog_params
      params.require(:dog).permit(:name, :user_id, :sex, :breed, :dob, :picture, :sound, :description)
    end
end
