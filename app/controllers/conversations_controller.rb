class ConversationsController < ApplicationController
  #before_filter :authenticate_user!
  before_filter :get_conversation, only: [:show, :edit, :update, :destroy]

  def index
    @conversations =  current_user.mailbox.conversations
  end

  def new
    @user = User.find(params[:user_id])
  end


  def show

    @conversation.mark_as_read(current_user)
  end

  def create
    @recipient = User.find(params[:user_id])
    @conversation = current_user.send_message(@recipient, conversation_params[:body], conversation_params[:subject])

    redirect_to conversations_path
  end

  def reply
    @conversation = current_user.mailbox.conversations.find(params[:id])
    #Method to display the conversations
    @messages = @conversation.messages
    #Method to reply to conversation
     @reply = current_user.reply_to_conversation(@conversation, conversation_params[:body])

    redirect_to conversation_path
  end


  private
  def get_conversation
    @conversation = current_user.mailbox.conversations.find(params[:id])
  end
  def conversation_params
    params.permit(:body, :subject)
  end

  
end