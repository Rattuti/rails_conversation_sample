class Message < ApplicationRecord
  belongs_to :conversation
  belongs_to :user

  validates_presence_of :content, :conversation_id, :user_id
  def set_time
    created_at.strftime("%m/%d %H:%M")
  end
end