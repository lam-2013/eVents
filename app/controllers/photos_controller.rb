class PhotosController < ApplicationController
  # check if the user is logged in
  before_filter :signed_in_user
  # check if the user is allowed to delete a photos
  before_filter :correct_user, only: :destroy


  def destroy
    @photo.destroy
    redirect_to current_user
  end

  private

  def correct_user
    # does the user have a post with the given id?
    @photo = current_user.photos.find_by_id(params[:id])
    # if not, redirect to the home page
    redirect_to root_url if @photo.nil?
  end

end