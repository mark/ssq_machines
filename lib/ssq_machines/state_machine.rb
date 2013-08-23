require 'ssq_machines/behavior'
require 'ssq_machines/frame'

class SsqMachines::StateMachine < SsqMachines::BaseMachine

  ################
  #              #
  # Declarations #
  #              #
  ################
  
  class MultipleStateError < StandardError; end
  
  ###############
  #             #
  # Constructor #
  #             #
  ###############
  
  def initialize
    @state = nil
  end
  
  ####################
  #                  #
  # Instance Methods #
  #                  #
  ####################
  
  def completed?
    @state.nil?
  end

  def current_state
    @state.state if @state
  end

  def current_behavior
    @state.behavior if @state
  end

  private
  
  def add_state(state)
    @state = @state ? raise(MultipleStateError) : state
  end

  def next_state
    @state.tap { @state = nil }
  end
    
end
