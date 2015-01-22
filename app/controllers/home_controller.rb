class HomeController < ApplicationController

  def index
      @q = Dog.ransack(params[:q])
      @dogs = @q.result(distinct: true)
  end

  def faq

    @q = Dog.ransack(params[:q])
    @dogs = @q.result(distinct: true)
  end

  def about
    @q = Dog.ransack(params[:q])
    @dogs = @q.result(distinct: true)
  end


end
