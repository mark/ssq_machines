class SsqMachines::Execution

  ################
  #              #
  # Declarations #
  #              #
  ################
  
  attr_reader :context, :transitions, :waiting

  ##########
  #        #
  # Errors #
  #        #
  ##########
  
  class MissingContextError < StandardError; end

  ###############
  #             #
  # Constructor #
  #             #
  ###############
  
  def initialize(context)
    raise MissingContextError unless context

    @context     = context
    @transitions = []
    @waiting     = false
  end

  ####################
  #                  #
  # Instance Methods #
  #                  #
  ####################
  
  def transition(*args)
    @transitions << Transition.new(*args)
  end

  def transition_from(frame)
    @transitions.map! { |transition| frame.transition_to(transition) }
  end

  def wait
    @waiting = true
  end

end

