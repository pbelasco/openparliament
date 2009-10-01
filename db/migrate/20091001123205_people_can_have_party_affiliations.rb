class PeopleCanHavePartyAffiliations < ActiveRecord::Migration
  def self.up
    create_table :parties do |t|
      t.string :acronym
      t.string :name
    end
    
    create_table :party_affiliations do |t|
      t.date    :started_at
      t.date    :ended_at
      t.integer :person_id
      t.integer :party_id
    end
  end

  def self.down
    drop_table :parties
    drop_table :party_affiliations
  end
end
