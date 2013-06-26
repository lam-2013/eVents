class EventsController < ApplicationController

  # check if the user is logged in
  before_filter :signed_in_user

  def show
   @event = Event.find(params[:id])
  end

  private

  def correct_user
    # utente ha partecipato a degli eventi
    # with the given id?
    @events = current_user.followed_events.find_by_id(params[:id])
    # if not, redirect to the home page
    redirect_to root_url if @events.nil?
  end

end
