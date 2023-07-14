# frozen_string_literal: true

class PostsController < ApplicationController
  def index
    @posts_with_comments = load_posts_with_comments
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user

    if @post.save
      flash[:notice] = 'Post successfully created!'
      redirect_to '/index'
    else
      @posts_with_comments = load_posts_with_comments
      @post = Post.new
      render :index, status: :unprocessable_entity
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    flash[:notice] = 'Post deleted!'
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:body, :picture)
  end

  def load_posts_with_comments
    posts = (current_user.posts + current_user.friends.flat_map(&:posts))
    posts.map { |post| [post, post.comments.includes(:user, picture_attachment: :blob)] }
  end
end
