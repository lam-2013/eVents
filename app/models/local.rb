# == Schema Information
#
# Table name: locals
#
#  id         :integer          not null, primary key
#  name       :string
#  tipo       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Local < ActiveRecord::Base

   attr_accessible :name, :tipo

   #A local has many followers through these relationships
   has_many :followers, through: :reverse_users_follow_locals
   # name sempre presente lunghezza max 50 caratteri
   validates :name, presence: true, length: {maximum: 50}

   #ricerca locali
   def self.search(name)
     where( "name LIKE ?","%#{name}%")
   end

end