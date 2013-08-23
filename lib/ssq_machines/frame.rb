require 'ssq_machines/transition'

class SsqMachines::Frame < SsqMachines::Transition
    
  ###############
  #             #
  # Constructor #
  #             #
  ###############
  
  def initialize(*)
    super
    
    raise NoBehaviorError unless @behavior

    @state ||= behavior.initial_state
  end

  #################
  #               #
  # Class Methods #
  #               #
  #################
  
  def self.transition_frame(frame, transition)
    if transition.behavior
      new(transition.behavior, transition.state)
    else
      new(frame.behavior, transition.state || frame.state)
    end
  end
  
  ####################
  #                  #
  # Instance Methods #
  #                  #
  ####################
  
  def execute(context)
    behavior.execute(state, context).tap do |execution|
      execution.transition_from self
    end
  end

  def transition_to(transition)
    self.class.transition_frame(self, transition)
  end

end