require 'spec_helper'

describe Party do
  before(:each) do
    @valid_attributes = {
      :acronym => "value for acronym",
      :name => "value for name"
    }
  end

  it "should create a new instance given valid attributes" do
    Party.create!(@valid_attributes)
  end
end
