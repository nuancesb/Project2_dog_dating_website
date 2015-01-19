class ConversationsController < ApplicationController
  #before_filter :authenticate_user!
  before_filter :get_conversation, only: [:show, :edit, :update, :destroy]

  def index
    @conversations =  current_user.mailbox.conversations
  end

  def show
    @conversation.mark_as_read(current_user)
  end

  def create
    
  end

  def reply
    
  end


  private
  def get_conversation
    @conversation = current_user.mailbox.conversations.find(params[:id])
  end
  
end