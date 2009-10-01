class TrackBrChamberPersonMetadata < ActiveRecord::Migration
  def self.up
    create_table :br_chamber_legislator_import_metadatas do |t|
      t.integer :chamber_id
      t.integer :person_id
    end
  end

  def self.down
    drop_table :br_chamber_legislator_import_metadatas
  end
end
