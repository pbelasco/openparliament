class Person < ActiveRecord::Base
  fields do
    firstname :string
    middlename :string
    lastname :string
    nickname :string
    birthday :date
    gender :string
  end
end
