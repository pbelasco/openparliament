class Vote < ActiveRecord::Base

  fields do
    value :string
  end

  belongs_to :person
  belongs_to :roll_call

end
