# frozen_string_literal: true

class ProfilesController < ApplicationController
  def show
    @profile = User.find(params[:id]).profile
  end

  def edit
    @profile = current_user.profile
  end

  def update
    @profile = current_user.profile

    if @profile.update(profile_params)
      flash[:notice] = 'Profile updated sucessfully!'
      redirect_to root_path
    else
      flash.now[:warning] = 'Something went wrong!'
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def profile_params
    params.require(:profile).permit(:first_name, :last_name)
  end
end
