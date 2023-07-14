# frozen_string_literal: true

class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:id])
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      flash[:notice] = 'Post successfully created!'
      redirect_to posts_url
    else
      @post = Post.new
      @posts_with_comments = load_posts_with_comments
      render 'posts/index', status: :unprocessable_entity
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    flash[:notice] = 'Comment deleted!'
    redirect_to posts_path
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def load_posts_with_comments
    posts = (current_user.posts + current_user.friends.flat_map(&:posts))
    posts.map { |post| [post, post.comments.includes(:user)] }
  end
end
