# == Schema Information
#
# Table name: users_follow_locals
#
#  id          :integer          not null, primary key
#  follower_id :integer
#  followed_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class UsersFollowLocal < ActiveRecord::Base

  attr_accessible :followed_id

  # utente segue più locali
  belongs_to :follower, class_name: 'User'

  # a relationship belongs to a followed user
  belongs_to :followed, class_name: 'Local'

  # both model attributes must be always present
  validates :follower_id, presence: true
  validates :followed_id, presence: true

end
