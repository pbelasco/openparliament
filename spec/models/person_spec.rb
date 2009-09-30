require 'spec/spec_helper'

describe Person do
  before(:each) do
    @valid_attributes = {
      :firstname => "value for firstname",
      :middlename => "value for middlename",
      :lastname => "value for lastname",
      :nickname => "value for nickname",
      :birthday => Date.today,
      :gender => "value for gender"
    }
  end

  it "should create a new instance given valid attributes" do
    Person.create!(@valid_attributes)
  end
end
