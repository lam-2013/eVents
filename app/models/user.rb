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

  attr_accessible :email, :name, :password, :password_confirmation

  #metodo autenticazione del sistema
  has_secure_password

  # each user can have some posts associated and they must be destroyed together with the user
  has_many :posts, dependent: :destroy

  has_many :photos, dependent: :destroy

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

  # private methods
  private

  def create_remember_token
    # create a random string, save for use in URIs and cookies, for the user remember token
    self.remember_token = SecureRandom.urlsafe_base64
  end

end