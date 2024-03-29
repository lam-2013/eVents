class MessagesController < ApplicationController
  # check if the user is logged in
  before_filter :signed_in_user
  # check if the user is allowed to delete a message
  before_filter :correct_user, only: :destroy

  # only the new action should respond to javascript
  respond_to :js, only: :new

  def new
    @user = User.find(params[:user])
    # create a new message
    @message = Message.new

    # reply to an existing message
    if params[:message]
      # get the message
      subject = Message.find(params[:message]).subject
      # set the reply subject
      @message.subject = "Re: #{subject}"
    end

    respond_with @user, @message
  end

  def create
    # build a new message from the information contained in the "new message" form
    # support on simple-private-messages gem
    @message = Message.new
    @message.subject = params[:message][:subject]
    @message.body = params[:message][:body]
    @message.sender = User.find(params[:message][:sender])
    recipient = User.find(params[:message][:recipient])
    @message.recipient = recipient

    if @message.save
      flash[:success] = "Message sent to #{recipient.name}!"
      redirect_to root_url
    else
      render 'pages/home'
    end
  end

  def destroy
    # a sent message must be deleted differently from a received one
    if current_user.received_messages.find_by_id(@message.id).nil?
      # the message has been sent from the user
      @message.mark_deleted
    else
      # the message has been received
      @message.mark_deleted(current_user)
    end
    redirect_to current_user
  end

  private

  def correct_user
    # did the user receive a message with the given id?
    @message = current_user.received_messages.find_by_id(params[:id])
    # did the user send a message with the given id?
    @message = current_user.sent_messages.find_by_id(params[:id]) unless @message
    # if not, redirect to the home page
    redirect_to root_url if @message.nil?
  end

end