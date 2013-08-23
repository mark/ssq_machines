require 'ssq_machines/behavior'
require 'ssq_machines/frame'

class SsqMachines::QueueMachine < SsqMachines::BaseMachine
  
  ###############
  #             #
  # Constructor #
  #             #
  ###############
  
  def initialize
    @queue = []
  end
  
  ####################
  #                  #
  # Instance Methods #
  #                  #
  ####################
  
  def completed?
    @queue.empty?
  end

  private
  
  def add_state(state)
    # Implement Me!
  end

  def next_state
    # Implement Me!
  end
    
end
