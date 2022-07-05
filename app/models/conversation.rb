class Conversation < ActiveRecord::Base
    belongs_to :sender, foreign_key: :sender_id, class_name: 'User'
    belongs_to :recipient, foreign_key: :recipient_id, class_name: 'User'
    has_many :messages, dependent: :destroy
    validates_uniqueness_of :sender_id, scope: :recipient_id
  
    scope :with_user, -> (current_user) {where(sender_id: current_user.id).or(Conversation.where(recipient_id: current_user.id))}
  
    scope :between, -> (sender_id, recipient_id) {where(sender_id: sender_id, recipient_id: recipient_id).or(Conversation.where(sender_id: recipient_id, recipient_id: sender_id))}
  end