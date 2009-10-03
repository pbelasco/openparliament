class PartyAffiliation < ActiveRecord::Base
  fields do
    started_at :date
    ended_at :date
  end

  belongs_to :person
  belongs_to :party
end
