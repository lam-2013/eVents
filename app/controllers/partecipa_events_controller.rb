class PartecipaEventsController < ApplicationController
  # user must be signed in
  # per partecipare o meno ad un evento
  before_filter :signed_in_user

  respond_to :html, :js

  def create
    @event = Event.find(params[:partecipa_event][:evento_id])
    current_user.follow_event!(@event)
    # without javascript: redirect_to @user
    respond_with @user
    # Rails will look for a create.js.erb file for responding to this action with ajax
  end

  def destroy
    @event = PartecipaEvent.find(params[:id]).evento
    current_user.unfollow_event!(@event)
    # without javascript: redirect_to @user
    respond_with @user
    # Rails will look for a destroy.js.erb file for responding to this action with ajax
  end
end
