# frozen_string_literal: true

class UsersController < ApplicationController
  def index
    @users = User.all
    @friendships = current_user.friendships
    @friends = @friendships.select(&:mutual?).map(&:user)
  end

  def show
    @user = User.includes(:posts).find(params[:id])
  end

  def create_request
    User.find(params[:id]).friends << current_user

    flash[:success] = 'Friend request sent!'
    redirect_to root_path
  end

  def friend_list
    @requests = current_user.pending_friends
    @friends = current_user.active_friends
  end
end
