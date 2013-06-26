class SessionsController < ApplicationController

 #nuovo utente
  def new
  end

  def create
    user = User.find_by_name(params[:session][:name])
    # check if the retrieved user is valid
    if user && user.authenticate(params[:session][:password])
      # handle successful login
      sign_in user # sign in metodo implementato in SessionsHelper
      redirect_to user # redirect to user profile page
    else
      # errore nel log_in
      flash.now[:error] = 'Invalid name/password combination'
      # go back
      render 'new'
    end
  end

  def destroy
    # sign out the current user
    sign_out
    # go to the home_page
    redirect_to root_path
  end
end