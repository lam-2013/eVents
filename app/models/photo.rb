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
  default_scope order: 'posts.created_at DESC'

  validates :user_id, presence: true

  # content must be present, is a link to a remote picture
  validates :content, presence: true

end
