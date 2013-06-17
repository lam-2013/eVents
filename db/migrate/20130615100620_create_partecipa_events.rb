class CreatePartecipaEvents < ActiveRecord::Migration
  def change
    create_table :partecipa_events do |t|

      t.integer :partecipante_id
      t.integer :evento_id

      t.timestamps
    end

    # indexes
    add_index :partecipa_events, :partecipante_id
    add_index :partecipa_events, :evento_id
    # a user cannot follow another user more than one time...
    add_index :partecipa_events, [ :partecipante_id, :evento_id ], unique: true
  end
end
