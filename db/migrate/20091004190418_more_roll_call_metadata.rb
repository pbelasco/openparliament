class MoreRollCallMetadata < ActiveRecord::Migration
  def self.up
    rename_column :br_chamber_roll_call_import_metadatas, :chamber_id, :chamber_roll_call_id
    add_column :br_chamber_roll_call_import_metadatas, :legislative_session_type, :string
    add_column :br_chamber_roll_call_import_metadatas, :legislative_session_number, :string
    add_column :br_chamber_roll_call_import_metadatas, :legislative_session_ordinary_boolean, :string
    add_column :br_chamber_roll_call_import_metadatas, :session_number, :string
    add_column :br_chamber_roll_call_import_metadatas, :session_ordinary_boolean, :string
    change_column :br_chamber_roll_call_import_metadatas, :chamber_roll_call_id, :string, :limit => 255
  end

  def self.down
    rename_column :br_chamber_roll_call_import_metadatas, :chamber_roll_call_id, :chamber_id
    remove_column :br_chamber_roll_call_import_metadatas, :legislative_session_type
    remove_column :br_chamber_roll_call_import_metadatas, :legislative_session_number
    remove_column :br_chamber_roll_call_import_metadatas, :legislative_session_ordinary_boolean
    remove_column :br_chamber_roll_call_import_metadatas, :session_number
    remove_column :br_chamber_roll_call_import_metadatas, :session_ordinary_boolean
    change_column :br_chamber_roll_call_import_metadatas, :chamber_id, :integer
  end
end
