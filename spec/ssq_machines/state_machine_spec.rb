require 'spec_helper'

include SsqMachines

describe StateMachine do

  it "should exist" do
    StateMachine.wont_equal nil
  end
  
  subject { StateMachine.new.tap { |m| m.add behavior } }
    
  class SimpleBehavior
    include Behavior
    def initial_state; "foo"; end
    def foo(*); next_state "bar"; end
  end

  class NoopBehavior
    include Behavior
    def initial_state; "foo"; end
    def foo(*); repeat; end
  end

  class TerminalBehavior
    include Behavior
    def initial_state; "foo"; end
    def foo(*); end
  end

  describe :initial_state do
    
    let(:behavior) { SimpleBehavior.new }
    
    it "should follow a transition" do
      subject.current_state.must_equal "foo"
    end
    
  end
  
  describe :step do
      
    describe "no-ops" do
      
      let(:behavior) { NoopBehavior.new }
      
      it "should follow a transition" do
        subject.step({})
        subject.current_state.must_equal "foo"
      end

    end
    
    describe "transitions" do
      
      let(:behavior) { SimpleBehavior.new }
      
      it "should follow a transition" do
        subject.step({})
        subject.current_state.must_equal "bar"
      end
    end
  
    describe "completions" do
      
      let(:behavior) { TerminalBehavior.new }
      
      it "should end at a completion" do
        subject.step({})
        subject.current_state.must_be_nil
        subject.completed?.must_equal true
      end
      
      it "should raise when trying to step again" do
        subject.step({})
        lambda { subject.step({}) }.must_raise(StateMachine::CompletedMachineExecution)
      end
      
    end
    
  end
  
  
end
