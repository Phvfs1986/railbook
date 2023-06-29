# frozen_string_literal: true

class LikesController < ApplicationController
  def add_like
    @post = Post.find(params[:id])
    current_user.liked_posts << @post

    redirect_to posts_path
  end

  def remove_like
    @post = Post.find(params[:id])

    current_user.liked_posts.delete(@post)

    redirect_to posts_path
  end
end
