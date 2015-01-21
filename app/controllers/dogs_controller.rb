class DogsController < ApplicationController
  before_action :set_dog, only: [:show, :edit, :update, :destroy]

  load_and_authorize_resource
  
  respond_to :html

  def index
    @dogs = Dog.all
    respond_with(@dogs)
  end

  def show
    respond_with(@dog)
  end

  def new
    @dog = Dog.new
    respond_with(@dog)
  end

  def edit
  end

  def create
    @dog = Dog.new(dog_params)
    @dog.save
    respond_with(@dog)
  end

  def update
    @dog.update(dog_params)
    respond_with(@dog)
  end

  def destroy
    @dog.destroy
    respond_with(@dog)
  end

  private
    def set_dog
      @dog = Dog.find(params[:id])
    end

    def dog_params
      params.require(:dog).permit(:name, :user_id, :sex, :breed, :dob, :picture, :sound, :description)
    end
end
