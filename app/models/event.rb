# == Schema Information
#
# Table name: events
#
#  id         :integer          not null, primary key
#  name       :string

#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Event < ActiveRecord::Base

  attr_accessible :name, :tipo

  #A event has many partecipanti through these relationships
  has_many :partecipante, through: :reverse_partecipa_events

  # name sempre presente lunghezza max 50 caratteri
  validates :name, presence: true, length: {maximum: 50}

end
