# == Schema Information
#
# Table name: events
#
#  id         :integer          not null, primary key
#  name       :string
#  tipo       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Event < ActiveRecord::Base

  attr_accessible :name, :tipo

  #A event has many partecipanti through these relationships
  has_many :partecipanti, through: :reverse_partecipa_events

  # name sempre presente lunghezza max 50 caratteri
  validates :name, presence: true, length: {maximum: 50}

  #cerca per tipo di evento
  def self.search(type)
   where( "tipo LIKE ?","%#{type}%")
  end

end
