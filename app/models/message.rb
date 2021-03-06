class Message < ApplicationRecord
  after_create_commit { MessageBroadcastJob.perform_later self }

  belongs_to :haunt
  belongs_to :conversation

  def display_haunt_name
    haunt.display_name
  end

  def sender_id
    conversation.sender_id
  end

  def recipient_id
    conversation.recipient_id
  end
end
