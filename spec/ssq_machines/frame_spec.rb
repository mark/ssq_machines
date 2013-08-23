require 'spec_helper'

describe SsqMachines::Frame do
  
  class DummyBehavior
    include SsqMachines::Behavior
    initial_state :foo
    def initialize(name = nil); @name = name; end
  end
  
  describe :constructor do
    it "should work when passed in a behavior" do
      r = SsqMachines::Frame.new(DummyBehavior)
      
      r.behavior.must_be_instance_of DummyBehavior
      r.state.must_equal :foo
    end
    
    it "should work when a nil state is passed in" do
      r = SsqMachines::Frame.new(DummyBehavior, nil)
      
      r.behavior.must_be_instance_of DummyBehavior
      r.state.must_equal :foo
    end
    
  end
  
  describe "Frame::transition_frame" do
    
    ProxyObject = Struct.new(:behavior, :state)
    
    let(:behavior)      { DummyBehavior.new("a") }
    let(:behavior_2)    { DummyBehavior.new("b") }
    
    let(:state_record)  { ProxyObject.new(behavior, :bar) }
    
    it "should use the initial state when transition has a behavior" do
      with_behavior = ProxyObject.new( behavior )
      r = SsqMachines::Frame.transition_frame(state_record, with_behavior)
      
      r.behavior.must_equal behavior
      r.state.must_equal :foo
    end
    
    it "should use the transition entirely when it has both" do
      with_both = ProxyObject.new( behavior_2, :baz )
      r = SsqMachines::Frame.transition_frame(state_record, with_both)
      
      r.behavior.must_equal behavior_2
      r.state.must_equal :baz
    end
    
    it "should repeat the transition when transitioning to nil" do
      with_neither = ProxyObject.new
      r = SsqMachines::Frame.transition_frame(state_record, with_neither)
      
      r.behavior.must_equal behavior
      r.state.must_equal :bar
    end
    
    it "should keep the behavior when a state is passed in" do
      with_state = ProxyObject.new( nil, :quux )
      r = SsqMachines::Frame.transition_frame(state_record, with_state)
      
      r.behavior.must_equal behavior
      r.state.must_equal :quux
    end
    
  end
  
end
