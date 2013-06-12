# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  password_digest :string(255)
#  remember_token  :string(255)

class User < ActiveRecord::Base

  attr_accessible :email, :name, :password, :password_confirmation, :category

  #metodo autenticazione del sistema
  has_secure_password

  # each user can send/receive some private messages (thanks to the simple-private-messages gem)
  has_private_messages

  # each user can have some posts associated and they must be destroyed together with the user
  has_many :posts, dependent: :destroy
  # each user can have some photos associated and they must be destroyed together with the user
  has_many :photos, dependent: :destroy

  #for users follow locals

  #utente segue più locali
  has_many :users_follow_locals, foreign_key: 'follower_id', dependent: :destroy


  #for follower and followed
  has_many :relationships, foreign_key: 'follower_id', dependent: :destroy

  has_many :followed_users, through: :relationships, source: :followed

  has_many :reverse_relationships, foreign_key: 'followed_id', class_name: Relationship, dependent: :destroy

  has_many :followers, through: :reverse_relationships

  # put the email in downcase before saving the user
  before_save { |user| user.email = email.downcase }
  # call the create_remember_token private method before saving the user
  before_save :create_remember_token

  # name sempre prsente lunghezza max 50 caratteri
  validates :name, presence: true, length: {maximum: 50}

  # espressione controllo email
  VALID_EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/

  # email must be always present, unique and with a specific format
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false,}
  #validates :email, presence: true,:uniqueness => true,
  #:format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/, :on => :create }

  # password sempre presente lunghezza min 6 caratteri
  validates :password, presence: true, length: { minimum: 6 }

  # password_confirmation sempre presente
  validates :password_confirmation, presence: true

  #utente segue un locale?
  def following_local?(local)
    users_follow_locals.find_by_followed_id(local.id)
  end

  #per seguire un locale
  def follow_local!(local)
    users_follow_locals.create!(followed_id:local.id)
  end

  #per smettere di seguire un locale
  def unfollow_local!(local)
    users_follow_locals.find_by_followed_id(local.id).destroy
  end


  #un utente ne sta seguendo un altro?
  def following?(other_user)
    relationships.find_by_followed_id(other_user.id)
  end

  #seguire un altro utente (crea una nuova relationship)
  def follow!(other_user)
    relationships.create!(followed_id:other_user.id)
  end

  #smettere di seguire un utente
  def unfollow!(other_user)
    relationships.find_by_followed_id(other_user.id).destroy
  end

  # get the post to show in the wall
  def feed
    Post.from_users_followed_by(self)
  end


  # private methods
  private

  def create_remember_token
    # create a random string, save for use in URIs and cookies, for the user remember token
    self.remember_token = SecureRandom.urlsafe_base64
  end

end