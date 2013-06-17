class EventsController < ApplicationController

  #lista eventi del DB
  def index
    @events = Event.paginate(page: params[:page])
  end

end
