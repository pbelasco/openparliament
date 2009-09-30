class CreatePerson < ActiveRecord::Migration
  def self.up
    create_table :people do |t|
      t.string :firstname
      t.string :middlename
      t.string :lastname
      t.string :nickname
      t.date   :birthday
      t.string :gender
    end
  end

  def self.down
    drop_table :people
  end
end
