#!../../script/runner
require 'faster_csv'

Metadata = BrChamberRollCallImportMetadata

FasterCSV.foreach('roll_calls.csv', :headers => true) do |row|
  meta = Metadata.find_by_chamber_roll_call_id(row['roll_call_id'])

  # for now, this script is only for insertion, so if there's already
  # a record, we don't update the info
  unless meta
    meta = Metadata.new(:chamber_roll_call_id => row['roll_call_id'])
    meta.legislative_session_type = row['legislative_session_type']
    meta.legislative_session_number = row['legislative_session_number']
    meta.legislative_session_ordinary_boolean = row['legislative_session_ordinary_boolean']
    meta.session_number = row['session_number']
    meta.session_ordinary_boolean = row['session_ordinary_boolean']
    meta.save!

    roll_call = RollCall.new
    day, month, year = row['end_date'].split('/').map(&:to_i)
    roll_call.date = Date.new(year, month, day)

    bill = Bill.new

    bill.bill_type = row['bill_type']
    bill.number = row['bill_number']
    bill.year = row['bill_year']
    bill.name = row['bill_name']
    bill.save!

    roll_call.bill = bill
    roll_call.save!
    meta.roll_call = roll_call
    meta.save!
  end
end
