# frozen_string_literal: true

class UsersController < ApplicationController
  def index
    @users = User.all
    @friendships = current_user.friendships
    @friends = @friendships.select(&:mutual?).map(&:user).uniq
  end

  def create_request
    current_user.friends << User.find(params[:id])

    redirect_to root_path
  end
end
