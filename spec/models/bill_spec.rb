require 'spec_helper'

describe Bill do
  before(:each) do
    @valid_attributes = {
      :type => "value for type",
      :number => 1,
      :year => 1
    }
  end

  it "should create a new instance given valid attributes" do
    Bill.create!(@valid_attributes)
  end
end
