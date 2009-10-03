require 'spec_helper'

describe PartyAffiliation do
  before(:each) do
    @valid_attributes = {
      :started_at => Date.today,
      :ended_at => Date.today
    }
  end

  it "should create a new instance given valid attributes" do
    PartyAffiliation.create!(@valid_attributes)
  end
end
