# frozen_string_literal: true

class CommentsController < ApplicationController
  def new
    @post = Post.find(params[:id])
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user
  end

  def create
    @post = Post.includes(:user).find(params[:id])
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      flash[:notice] = 'Post successfully created!'
      redirect_to posts_url
    else
      @posts = Post.all
      @posts_with_comments = @posts.map { |post| [post, post.comments.includes(:user)] }
      render 'posts/index', status: :unprocessable_entity
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
