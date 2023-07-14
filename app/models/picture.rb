# frozen_string_literal: true

class Picture < ApplicationRecord
  belongs_to :user
  has_many :comments, as: :commentable
end
