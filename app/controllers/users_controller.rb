class UsersController < ApplicationController

  # check se utente è già loggato prima di chiamare edit update index e destroy
  before_filter :signed_in_user, only: [:edit, :update, :index, :destroy,:messages]
  # check se l'utente corrente è l'utente corrente , chiamata prima di edit e di update
  before_filter :correct_user, only: [:edit, :update, :messages]
  # check if the current user is also an admin, filtro applicato solo al destroy per sicurezza!
  before_filter :admin_user, only: :destroy

  #autocomplete :user, :name, :full => true


  #def hints// metodo per i suggerimenti
  def hints
    @users = User.category_condition(current_user)
  end

  #def serarch //metodo per a ricerca
  # Paginated search for users
  def search
    @users = User.search(params[:search]).paginate(page: params[:page])
  end

  def event_spettacolo
    @title = 'Eventi about spettacolo'
    @user = User.find(params[:id])
    @events = Event.search(params["Spettacolo"]).paginate(page: params[:page])
    render 'events/index'
  end

  def event_f_r
    @title = 'Eventi about Food&Restaurant'
    @user = User.find(params[:id])
    @events = Event.search("Food&restaurant").paginate(page: params[:page])
    render 'events/index'
  end

  def event_nightclubbing
    @title = 'Eventi about Food&Restaurant'
    @user = User.find(params[:id])
    @events = Event.search('Nightclubbing').paginate(page:params[:page])
    render 'events/index'
  end

  #miei locali
  def my_locals
    @user = User.find(params[:id])
    @locals = @user.followed_locals.paginate(page: params[:page])
  end

  #miei eventi
  def my_events
    @user = User.find(params[:id])
    @events = @user.followed_events.paginate(page: params[:page])
  end


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

  def photos
    # with the current restrictions, user is always the current_user
    @user = User.find(params[:id])
    @photos = @user.photos.paginate(page: params[:page])
  end

  # Paginate message index
  def messages
    # with the current restrictions, user is always the current_user
    @user = User.find(params[:id])
    @messages = @user.received_messages.paginate(page: params[:page])
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