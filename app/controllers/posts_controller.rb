# frozen_string_literal: true

class PostsController < ApplicationController
  def index
    @posts_with_comments = load_posts_with_comments
    @post = Post.new
  end

  def create
    @post = Post.new
    @post.user = current_user

    if @post.save
      flash[:notice] = 'Post successfully created!'
      redirect_to posts_url
    else
      @posts_with_comments = load_posts_with_comments
      render :index, status: :unprocessable_entity
    end
  end

  private

  def post_params
    params.require(:post).permit(:body)
  end

  def load_posts_with_comments
    posts = (current_user.posts + current_user.friends.flat_map(&:posts))
    posts.map { |post| [post, post.comments.includes(:user)] }
  end
end
