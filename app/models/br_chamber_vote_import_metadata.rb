class BrChamberVoteImportMetadata < ActiveRecord::Base
  fields do
    legislative_session_type :string
    legislative_session_number :string
    legislative_session_ordinary_boolean :string
    session_number :string
    session_ordinary_boolean :string
    chamber_roll_call_id :string
    legislator_subscription_number :string
  end

  belongs_to :vote
end

