class ConversationsController < ApplicationController
    def index
        @conversations = Conversation.with_user(current_user)
    end

  def create
    unless @conversation = Conversation.between(params[:sender_id], params[:recipient_id]).take
      @conversation = Conversation.create!(conversation_params)
    end
    redirect_to conversation_messages_path(@conversation)
  end
    
    private
    
    def conversation_params
        params.permit(:sender_id, :recipient_id)
    end
end
