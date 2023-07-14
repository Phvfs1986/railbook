# frozen_string_literal: true

class Post < ApplicationRecord
  default_scope { order(created_at: :desc) }

  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :liked_by_users, through: :likes, source: :user, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
  has_one_attached :picture

  validates :body, presence: true, length: { in: 10..100 }
end
