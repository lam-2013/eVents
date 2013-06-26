class UsersFollowLocalsController < ApplicationController
  # user must be signed in to follow/unfollow someone
  before_filter :signed_in_user

  respond_to :html, :js

  def create
    @local = Local.find(params[:users_follow_local][:followed_id])
    current_user.follow_local!(@local)
    # without javascript: redirect_to @user
    respond_with @user
    # Rails will look for a create.js.erb file for responding to this action with ajax
  end

  def destroy
    @local = UsersFollowLocal.find(params[:id]).locale
    current_user.unfollow_local!(@local)
    # without javascript: redirect_to @user
    respond_with @user
    # Rails will look for a destroy.js.erb file for responding to this action with ajax
  end
end