require 'ssq_machines/behavior'
require 'ssq_machines/frame'

class SsqMachines::StackMachine < SsqMachines::BaseMachine
  
  ###############
  #             #
  # Constructor #
  #             #
  ###############
  
  def initialize
    @stack = []
  end
  
  ####################
  #                  #
  # Instance Methods #
  #                  #
  ####################
  
  def completed?
    @stack.any?
  end

  private
  
  def add_state(state)
    @stack.push state
  end

  def next_state
    @stack.pop
  end
    
end
