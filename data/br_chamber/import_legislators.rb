#!../../script/runner
require 'faster_csv'

Metadata = BrChamberLegislatorImportMetadata

FasterCSV.foreach('legislators.csv', :headers => true) do |row|
  meta = Metadata.find_by_chamber_id(row['chamber_id'])

  # for now, this script is only for insertion, so if there's already
  # a record, we don't update the info
  unless meta
    meta = Metadata.new(:chamber_id => row['chamber_id'])
    meta.subscription_number = row['subscription_number']

    person = Person.new
    person.nickname = row['nickname']
    person.save!
    meta.person = person
    meta.save!
  end
end
