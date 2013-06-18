class LocalsController < ApplicationController

  # check if the user is logged in
  before_filter :signed_in_user

  before_filter :correct_user



  private
  def correct_user
    # does the user have a post with the given id?
    @local = current_user.followed_locals.find_by_id(params[:id])
    # if not, redirect to the home page
    redirect_to root_url if @local.nil?
  end

end
