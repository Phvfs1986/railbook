# frozen_string_literal: true

module ApplicationHelper
  def user_avatar(user, size = 100)
    if user.avatar_url.nil?
      if user.avatar.attached?
        user.avatar.variant(resize: "#{size}x#{size}!")
      else
        user.gravatar_url(size:)
      end
    else
      user.avatar_url
    end
  end
end

# if user.avatar_url.nil?
#  image_tag user_avatar(user)
# else
#  image_tag user.avatar_url
# end
