# frozen_string_literal: true

class PostsController < ApplicationController
  def index
    @posts = (current_user.posts + current_user.friends.flat_map(&:posts))
    @posts_with_comments = @posts.map { |post| [post, post.comments.includes(:user)] }
  end

  def new
    @post = current_user.posts.build(post_params)
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      flash[:notice] = 'Post successfully created!'
      redirect_to posts_url
    else
      @posts = Post.all
      render :index, status: :unprocessable_entity
    end
  end

  private

  def post_params
    params.require(:post).permit(:body)
  end
end
