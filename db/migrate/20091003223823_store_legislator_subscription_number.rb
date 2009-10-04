class StoreLegislatorSubscriptionNumber < ActiveRecord::Migration
  def self.up
    create_table :br_chamber_roll_call_import_metadatas do |t|
      t.integer :chamber_id
      t.integer :roll_call_id
    end
    
    add_column :br_chamber_legislator_import_metadatas, :subscription_number, :integer
  end

  def self.down
    remove_column :br_chamber_legislator_import_metadatas, :subscription_number
    
    drop_table :br_chamber_roll_call_import_metadatas
  end
end
