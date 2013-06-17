# == Schema Information
#
# Table name: partecipa_events
#
#  id          :integer          not null, primary key
#  partecipante_id :integer
#  evento_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class PartecipaEvent < ActiveRecord::Base

  attr_accessible :partecipante_id, :evento_id

  belongs_to :partecipante, class_name: 'User'

  belongs_to :evento, class_name: 'Event'

  # both model attributes must be always present
  validates :partecipante_id, presence: true
  validates :evento_id, presence: true

end
