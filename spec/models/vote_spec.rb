require 'spec_helper'

describe Vote do
  before(:each) do
    @valid_attributes = {
      :value => "value for value",
      :person_id => 1
    }
  end

  it "should create a new instance given valid attributes" do
    Vote.create!(@valid_attributes)
  end
end
