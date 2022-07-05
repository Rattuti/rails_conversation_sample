class MessagesController < ApplicationController
    before_action :set_conversation

    def index
        @messages = @conversation.messages.order(:created_at)
        @messages.where.not(user_id: current_user.id).update_all(read: true)
        if @messages.length > 10 && params[:show_all] != "true"
           @messages = @messages.last(10)
        end
        @message = Message.new
    end    

    def create
        @message = @conversation.messages.build(message_params)
        if @message.save
          redirect_to conversation_messages_path(@conversation)
        else
          render 'index'
        end
    end

    private
  
    def set_conversation
      @conversation = Conversation.find(params[:conversation_id])
    end

    def message_params
        params.require(:message).permit(:content, :user_id)
      end
  end