require 'spec_helper'

include SsqMachines

describe Behavior do
  
  it "should load" do
    Behavior.wont_be_nil
  end

  describe :initial_state do
  
    class SimpleBehavior
      include Behavior
      initial_state :foo
    end
    
    it "should allow you to specify state in the class" do
      SimpleBehavior.new.initial_state.must_equal "foo"
    end
    
  end
  
  describe :not_in_execution do
  
    it "should not let you call #context" do
      lambda { SimpleBehavior.new.context }.must_raise Behavior::NotInExecutionError
    end
    
    it "should not let you call #next_state" do
      lambda { SimpleBehavior.new.next_state }.must_raise Behavior::NotInExecutionError
    end
    
    it "should not let you call #repeat" do
      lambda { SimpleBehavior.new.repeat }.must_raise Behavior::NotInExecutionError
    end
    
  end
  
end
