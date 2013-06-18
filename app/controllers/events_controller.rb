class EventsController < ApplicationController

  # check if the user is logged in
  before_filter :signed_in_user

  before_filter :correct_user

  #lista eventi del DB
  #def index
  #  @events = Event.all

   # @event_spettacolo = @event.find_by_tipo("spettacolo")
    #@event_Nightclubbing = @event.find_by_tipo("Nightclubbing")
    #@event_FeR = @event.find_by_tipo("Food&Restaurant")
  #end


  private

  def correct_user
    # does the user have a post with the given id?
    @event = current_user.followed_events.find_by_id(params[:id])
    # if not, redirect to the home page
    redirect_to root_url if @event.nil?
  end


end
