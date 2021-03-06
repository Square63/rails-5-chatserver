class Haunt < ApplicationRecord
  mount_uploader :avatar, AvatarUploader
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :lockable

  has_many :messages
  has_many :conversations, class_name: 'Conversation', foreign_key: :sender_id

  scope :online, -> {where("id IN(?) AND updated_at > ?", $redis_onlines.keys, 5.minutes.ago)}

  def display_name
    [first_name, surname].join(' ')
  end

  def online?
    $redis_onlines.exists( self.id )
  end

  def self.online_haunts
    online
  end

  def appear
    $redis_onlines.set( self.id, nil, ex: 10*60 )
    AppearanceBroadcastJob.perform_later list, self
  end

  def away
    $redis_onlines.del( self.id )
    AppearanceBroadcastJob.perform_later list, self
  end

  def list
    self.class.online.to_a
  end
end
