#!../../script/runner
require 'faster_csv'

Metadata = BrChamberVoteImportMetadata

FasterCSV.foreach('votes.csv', :headers => true) do |row|
  meta = Metadata.find(:first, :conditions => {
                         :legislative_session_type => row['legislative_session_type'],
                         :legislative_session_number => row['legislative_session_number'],
                         :legislative_session_ordinary_boolean => row['legislative_session_ordinary_boolean'],
                         :session_number => row['session_number'],
                         :session_ordinary_boolean => row['session_ordinary_boolean'],
                         :chamber_roll_call_id => row['roll_call_id'],
                         :legislator_subscription_number => row['legislator_subscription_number']
                       })


  # for now, this script is only for insertion, so if there's already
  # a record, we don't update the info
  unless meta
    meta = Metadata.new({
      :legislative_session_type => row['legislative_session_type'],
      :legislative_session_number => row['legislative_session_number'],
      :legislative_session_ordinary_boolean => row['legislative_session_ordinary_boolean'],
      :session_number => row['session_number'],
      :session_ordinary_boolean => row['session_ordinary_boolean'],
      :chamber_roll_call_id => row['roll_call_id'],
      :legislator_subscription_number => row['legislator_subscription_number']
    })

    meta.save!

    roll_call = BrChamberRollCallImportMetadata.find(:first, :conditions => {
      :legislative_session_type => row['legislative_session_type'],
      :legislative_session_number => row['legislative_session_number'],
      :legislative_session_ordinary_boolean => row['legislative_session_ordinary_boolean'],
      :session_number => row['session_number'],
      :session_ordinary_boolean => row['session_ordinary_boolean'],
      :chamber_roll_call_id => row['roll_call_id']
    }).roll_call

    person_meta = BrChamberLegislatorImportMetadata.find_by_subscription_number(row['legislator_subscription_number'])
    person = person_meta ? person_meta.person : nil

    if person
      vote = Vote.new(:roll_call => roll_call, :person => person, :value => row['vote_value'])
      vote.save!
    end
  end
end
