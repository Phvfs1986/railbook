# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[facebook]

  has_one_attached :avatar

  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships

  has_many :received_friendships, class_name: 'Friendship', foreign_key: 'friend_id'
  has_many :received_friends, through: :received_friendships, source: 'user'

  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :post
  has_many :comments, dependent: :destroy

  include Gravtastic
  gravtastic

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.provider = auth.provider
      user.first_name = auth.info.first_name
      user.last_name = auth.info.last_name
      user.uid = auth.uid
      user.avatar_url = auth.info.image
    end
  end

  def self.new_with_session(params, session)
    if session['devise.user_attributes']
      new(session['devise.user_attributes'], without_protection: true) do |user|
        user.attributes = params
        user.valid?
      end
    else
      super
    end
  end

  def password_required?
    super && provider.blank?
  end

  def update_with_password(params, *options)
    if encrypted_password.blank?
      update(params, *options)
    else
      super
    end
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def active_friends
    friends.select { |friend| friend.friends.include?(self) }
  end

  def pending_friends
    friends.reject { |friend| friend.friends.include?(self) }
  end
end
