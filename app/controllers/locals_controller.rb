class LocalsController < ApplicationController

  #lista locali del DB
  def index
    @locals = Local.paginate(page: params[:page])
  end

end
