class CreateVoteMetadata < ActiveRecord::Migration
  def self.up
    create_table :br_chamber_vote_import_metadatas do |t|
      t.string  :legislative_session_type
      t.string  :legislative_session_number
      t.string  :legislative_session_ordinary_boolean
      t.string  :session_number
      t.string  :session_ordinary_boolean
      t.string  :chamber_roll_call_id
      t.string  :legislator_subscription_number
      t.integer :vote_id
    end
    
    add_column :votes, :roll_call_id, :integer
  end

  def self.down
    remove_column :votes, :roll_call_id
    
    drop_table :br_chamber_vote_import_metadatas
  end
end
