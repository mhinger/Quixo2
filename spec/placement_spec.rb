require "spec_helper"
require "game"
require "placement"


describe Placement, "Legal Placements" do
  
  before(:all) do
    @game = Game.new
    @place = Placement.new
  end
  
  it "has legal positions" do
    (@place.legal_pull_position(0) &&
     @place.legal_pull_position(2) &&
     @place.legal_pull_position(4) &&
     @place.legal_pull_position(10) &&
     @place.legal_pull_position(14) &&
     @place.legal_pull_position(20) &&
     @place.legal_pull_position(22) &&
     @place.legal_pull_position(24)).should be_true
  end
  
  it "has illegal positions" do
    (@place.legal_pull_position(6) &&
     @place.legal_pull_position(7) &&
     @place.legal_pull_position(8) &&
     @place.legal_pull_position(11) &&
     @place.legal_pull_position(12) &&
     @place.legal_pull_position(13) &&
     @place.legal_pull_position(16) &&
     @place.legal_pull_position(17) &&
     @place.legal_pull_position(18)).should be_false
  end
  
  it "checks push positions" do
    @place.legal_push_position(24, 24).should be_false
  end
  
end