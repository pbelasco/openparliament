class RollCall < ActiveRecord::Base

  fields do
    date :date
  end

  belongs_to :bill

end
