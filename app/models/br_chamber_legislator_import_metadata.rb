class BrChamberLegislatorImportMetadata < ActiveRecord::Base
  fields do
    chamber_id :integer, :unique, :required
    subscription_number :integer, :unique, :required
  end

  belongs_to :person
end
