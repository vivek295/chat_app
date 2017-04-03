class ConversationsController < ApplicationController
  before_action :authenticate_user!
	def create
    @conversation = Conversation.get(current_user.id, params[:user_id])
    @messages = @conversation.messages
    
    add_to_conversations unless conversated?
 
    respond_to do |format|
      format.js
    end
  end

  def index
		session[:conversations] ||= []
 
    @users = current_user.friends and current_user.inverse_friends
    @conversations = Conversation.includes(:recipient, :messages)
                                 .find(session[:conversations])
	end

	def close
    @conversation = Conversation.find(params[:id])
 
    session[:conversations].delete(@conversation.id)
 
    respond_to do |format|
      format.js
    end
  end
 
  private
 
  def add_to_conversations
    session[:conversations] ||= []
    session[:conversations] << @conversation.id
  end
 
  def conversated?
    session[:conversations].include?(@conversation.id)
  end
	
end