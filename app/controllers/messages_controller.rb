class MessagesController < ApplicationController

  #before_filter :authenticate_user!
  before_filter :get_mailbox, :get_box, :get_actor
  def index
    @q = Dog.ransack(params[:q])
    @dogs = @q.result(distinct: true)
    redirect_to conversations_path(:box => @box)
  end

end