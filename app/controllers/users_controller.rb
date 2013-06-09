class UsersController < ApplicationController

  # check se utente è già loggato prima di chiamare edit update index e destroy
  before_filter :signed_in_user, only: [:edit, :update, :index, :destroy]
  # check se l'utente corrente è l'utente corrente , chiamata prima di edit e di update
  before_filter :correct_user, only: [:edit, :update]
  # check if the current user is also an admin, filtro applicato solo al destroy per sicurezza!
  before_filter :admin_user, only: :destroy


  #followers
  def followers
    @title = 'Followers'
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  #following
  def following
    @title = 'Following'
    @user = User.find(params[:id])
    @users = @user.followed_users.paginate(page: params[:page])
    render 'show_follow'
  end

  #lista user del DB
  def index
    @users = User.paginate(page: params[:page])
  end

  #CREATE E NEW
  #UPDATE E EDIT
  #queste azioni lavorano a coppie con create e update prendo dati da form mentre new ed edit mostro dati
  #modifica parametri utente
  def edit
    # intentionally left empty since the correct_user method (called by before_filter) initialize the @user object
  end

  #carica info utente
  def update
    # intentionally left empty since the correct_user method (called by before_filter) initialize the @user object
    # without the correct_user method, this action should also contain:
    # @user = User.find(params[:id])
    # controllo update con successo?
    if @user.update_attributes(params[:user])
      # handle a successful update
      flash[:success] = 'Profile updated'
      # re-login the user con aggiornamenti
      sign_in @user
      # go to the user profile
      redirect_to @user
    else
      # update fallito
      render 'edit'
    end
  end

  #nuovo utente
  def new
    # init the user variable to be used in the sign up form
    @user = User.new
   # @user = User.create(name:"Elisabetta",email:"elisabetta.gallione@libero.it",
   #password:"ciaociao", password_confirmation:"ciaociao")
  end

  #crea nuovo utente
  def create
    # refine the user variable content with the data passed by the sign up form
    @user = User.new(params[:user])
    if @user.save
      # handle a successful save
      flash[:success] = 'Welcome to eVents!'
      #sign in automatico
      sign_in @user
      redirect_to @user
    else
      render 'new'
    end
  end

  #mostra un utente
  def show
    #get user with id :id
    @user = User.find(params[:id])
    # get and paginate the posts associated to the specified user
    @posts = @user.posts.paginate(page: params[:page])
    # get and paginate the photos associated to the specified user
    @photos = @user.photos.paginate(page: params[:page])

 end

  #candella utente
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = 'User deleted!'
    redirect_to users_url
  end

  #DA QUI IN POI SOLO METODI PRIVATI
  private

  # Redirect utente in sign_in se non è loggato
  #def signed_in_user
   # redirect_to sign_in_url, notice: 'Non hai ancora effettuato il log in ^_^ !' unless signed_in?
    # notice: 'Non hai ancora effettuato il log in ^_^ !' is the same of
    # flash[:notice] = 'Non hai ancora effettuato il log in ^_^ !'
 #end

  # Take le informazioni dell'utente corrente (id) e lo redirect alla home se non è corretto!
  def correct_user
    # init the user object to be used in the edit and update actions
    @user = User.find(params[:id])
    redirect_to root_path unless current_user?(@user)
    # the current_user?(user) method is defined in the SessionsHelper
  end

  # Redirect the user to the home page is she is not an admin
  def admin_user
    redirect_to root_path unless current_user.admin?
  end

end