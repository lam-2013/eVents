# == Schema Information
#
# Table name: locals
#
#  id         :integer          not null, primary key
#  name       :string

#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Local < ActiveRecord::Base

   attr_accessible :name

   has_many :reverse_relationships, foreign_key: followed_id, class_name: UsersFollowLocal, dependent: :destroy

   # name sempre presente lunghezza max 50 caratteri
   validates :name, presence: true, length: {maximum: 50}

end
