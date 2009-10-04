class Bill < ActiveRecord::Base

  fields do
    bill_type :string
    number :integer
    year :integer
    name :string
  end

end
