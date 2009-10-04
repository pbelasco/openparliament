class Person < ActiveRecord::Base
  fields do
    firstname :string
    middlename :string
    lastname :string
    nickname :string, :required
    birthday :date
    gender :string
  end

  has_many :votes

end
