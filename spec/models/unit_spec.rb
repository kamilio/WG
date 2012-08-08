require 'spec_helper'

describe Unit do
  before do #stub some stuff to no invoke capybara commands
    Unit.any_instance.stubs(:sex?).returns(false)
    Unit.any_instance.stubs(:apply).returns(true)
  end
  let(:instance) { Unit.new(:link => "http://www.wg-gesucht.de/en/wg-zimmer-in-Stuttgart-Sued.2792277.html") }
  it "should be valid" do
     instance.should be_valid
  end

  it "should be savable" do
     instance.save.should be_true
  end

  it "should validate uniqueness of wg_id" do
     instance.save
     unit = Unit.new(:link => "http://www.wg-gesucht.de/en/wg-zimmer-in-Stuttgart-Sued.2792277.html")
     expect { unit.save! }.to raise_exception
  end
   
  context "saved" do 
     subject { instance.save; next instance }
     its(:wg_id) { should == "2792277" }
  end 
end
