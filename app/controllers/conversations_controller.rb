class ConversationsController < ApplicationController
    def index
      @conversations = Conversation.where(sender_id: current_user.id)
      .or(Conversation.where(recipient_id: current_user.id))
    end
  
  
    def create
      unless @conversation = Conversation.where(sender_id: params[:sender_id], recipient_id: params[:recipient_id])
      .or(Conversation.where(sender_id: params[:recipient_id], recipient_id: params[:sender_id])).take
        @conversation = Conversation.create!(conversation_params)
      end
      redirect_to conversation_messages_path(@conversation)
    end
  
    private
  
    def conversation_params
      params.permit(:sender_id, :recipient_id)
    end
  end