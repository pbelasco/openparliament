class AddRollCallsVotesAndBills < ActiveRecord::Migration
  def self.up
    create_table :votes do |t|
      t.string  :value
      t.integer :person_id
    end
    
    create_table :roll_calls do |t|
      t.date    :date
      t.integer :bill_id
    end
    
    create_table :bills do |t|
      t.string  :type
      t.integer :number
      t.integer :year
    end
  end

  def self.down
    drop_table :votes
    drop_table :roll_calls
    drop_table :bills
  end
end
