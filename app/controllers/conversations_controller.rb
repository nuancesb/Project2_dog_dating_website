class ConversationsController < ApplicationController
  #before_filter :authenticate_user!
  before_filter :get_conversation, only: [:show, :edit, :update, :destroy]

  def index
    @q = Dog.ransack(params[:q])
    @dogs = @q.result(distinct: true)
    @conversations =  current_user.mailbox.conversations
    @inbox = current_user.mailbox.inbox
    @sentmessages = current_user.mailbox.sentbox
  end

  def new
    @q = Dog.ransack(params[:q])
    @dogs = @q.result(distinct: true)
    @user = User.find(params[:user_id])
  end


  def show
    @q = Dog.ransack(params[:q])
    @dogs = @q.result(distinct: true)
    @conversation.mark_as_read(current_user)

  end

  def create
    @q = Dog.ransack(params[:q])
    @dogs = @q.result(distinct: true)
    @recipient = User.find(params[:user_id])
    @conversation = current_user.send_message(@recipient, conversation_params[:body], conversation_params[:subject])

    redirect_to conversations_path
  end

  def reply
    @q = Dog.ransack(params[:q])
    @dogs = @q.result(distinct: true)
    @conversation = current_user.mailbox.conversations.find(params[:id])
    #Method to display the conversations
    @messages = @conversation.messages
    #Method to reply to conversation
    current_user.reply_to_conversation(@conversation, conversation_params[:body])

    redirect_to conversation_path
  end

  def delete
    @q = Dog.ransack(params[:q])
    @dogs = @q.result(distinct: true)
    @conversation.mark_as_deleted(current_user)
    redirect_to conversation_path
  end

  def trash
    @q = Dog.ransack(params[:q])
    @dogs = @q.result(distinct: true)
    @conversation = current_user.mailbox.conversations.find(params[:id])
    @conversation.destroy
    redirect_to conversations_path
  end

  def untrash
    @q = Dog.ransack(params[:q])
    @dogs = @q.result(distinct: true)
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