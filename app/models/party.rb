class Party < ActiveRecord::Base
  fields do
    acronym :string
    name :string
  end
end
