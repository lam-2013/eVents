# == Schema Information
#
# Table name: photos
#
#  id         :integer          not null, primary key
#  content    :string(255)
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Photo < ActiveRecord::Base
  attr_accessible :content

  belongs_to :user

  # descending order for getting the photos
  default_scope order: 'photos.created_at DESC'

  validates :user_id, presence: true

  # content must be present, is a link to a remote picture
  validates :content, presence: true

  # get user's photos plus all the photos posted by her followed users
  def self.from_users_followed_by(user)
    followed_user_ids = 'SELECT followed_id FROM relationships WHERE follower_id = :user_id'
    where("user_id IN (#{followed_user_ids}) OR user_id = :user_id", user_id: user.id)
  end

end
