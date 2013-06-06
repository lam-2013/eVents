class PagesController < ApplicationController
  def home
    @post = current_user.posts.build if signed_in?
    #@photo = current_user.photos.build if signed_in?
  end

  def about
  end

  def contact
  end

  def faq
  end

end
