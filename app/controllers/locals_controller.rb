class LocalsController < ApplicationController

  #lista locali del DB
  def index
    @local = Local.paginate(page: params[:page])
  end

  #followers
  def followers
    @title = 'Followers'
    @local = User.find(params[:id])
    @local = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  #mostra un locale
  def show
    #get local with id :id
    @local = Local.find(params[:id])
  end

end
