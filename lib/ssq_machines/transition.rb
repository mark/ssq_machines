require 'ssq_machines/behavior'

module SsqMachines
  
  class Transition
  
    ################
    #              #
    # Declarations #
    #              #
    ################

    attr_accessor :behavior, :state

    ##########
    #        #
    # Errors #
    #        #
    ##########
  
    class NoBehaviorError < StandardError; end

    ###############
    #             #
    # Constructor #
    #             #
    ###############
    
    def initialize(behavior_or_state = nil, state = nil)
      case behavior_or_state
      when Behavior # provided a behavior (and possibly a state)
        @behavior = behavior_or_state
        @state    = state
      when Class # provided a behavior subclass (and possbly a state)
        @behavior = behavior_or_state.new
        @state    = state
      when String, Symbol # provided a state (but not a behavior)
        @behavior = nil
        @state    = behavior_or_state
      # else
      #   msg = behavior_or_state ? "#{ behavior_or_state } is not a valid behavior" : "No behavior provided"
      #   raise NoBehaviorError, msg
      end
    end
    
  end
  
end
