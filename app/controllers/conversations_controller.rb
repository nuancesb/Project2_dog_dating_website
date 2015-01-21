class ConversationsController < ApplicationController
  #before_filter :authenticate_user!
  before_filter :get_conversation, only: [:show, :edit, :update, :destroy]

  def index
    @conversations =  current_user.mailbox.conversations
    @inbox = current_user.mailbox.inbox
    @sentmessages = current_user.mailbox.sentbox
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
    current_user.reply_to_conversation(@conversation, conversation_params[:body])

    redirect_to conversation_path
  end

  def delete
    @conversation.mark_as_deleted(current_user)
    redirect_to conversation_path
  end

  def trash
    @conversation = current_user.mailbox.conversations.find(params[:id])
    @conversation.destroy
    redirect_to conversations_path
  end

  def untrash
    conversation.untrash(current_user)
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