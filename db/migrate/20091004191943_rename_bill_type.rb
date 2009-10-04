class RenameBillType < ActiveRecord::Migration
  def self.up
    rename_column :bills, :type, :bill_type
  end

  def self.down
    rename_column :bills, :bill_type, :type
  end
end
