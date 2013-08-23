require 'spec_helper'

include SsqMachines

describe Transition do
  
  class DummyBehavior
    include Behavior
  end
  
  let(:behavior) { DummyBehavior.new }
  let(:klass)    { DummyBehavior }
  let(:string)   { "foo"}
  let(:symbol)   { :foo }
  
  it "should work when not given anything" do
    t = Transition.new()
    
    t.behavior.must_be_nil
    t.state.must_be_nil
  end
  
  it "should work when given nils" do
    t = Transition.new(nil, nil)
    
    t.behavior.must_be_nil
    t.state.must_be_nil
  end
  
  it "should work when given a behavior" do
    t = Transition.new(behavior)
    
    t.behavior.must_equal behavior
    t.state.must_be_nil
  end
  
  it "should work when given a behavior class" do
    t = Transition.new(klass)
    
    t.behavior.must_be_instance_of klass
    t.state.must_be_nil
  end
  
  it "should work when given a string" do
    t = Transition.new(string)
    
    t.behavior.must_be_nil
    t.state.must_equal string
  end
  
  it "should work when given a symbol" do
    t = Transition.new(symbol)
    
    t.behavior.must_be_nil
    t.state.must_equal symbol
  end
  
  it "should work when given a behavior and a state" do
    t = Transition.new(behavior, string)
    
    t.behavior.must_equal behavior
    t.state.must_equal string
  end
  
end
