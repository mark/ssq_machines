module SsqMachines::Behavior

  ##########
  #        #
  # Errors #
  #        #
  ##########  

  class NotInExecutionError     < StandardError; end
  class AlreadyInExecutionError < StandardError; end
  
  #################
  #               #
  # Class Methods #
  #               #
  #################

  module ClassMethods
  
    def initial_state(initial_state = nil)
      @initial_state ||= initial_state
    end
  
  end
  
  def self.included(base)
    base.send :extend, ClassMethods
  end
  
  ####################
  #                  #
  # Instance Methods #
  #                  #
  ####################

  def context
    execution.context
  end
  
  def initial_state
    self.class.initial_state
  end
  
  def execute(state, context)
    build_execution context

    send state

    flush_execution
  end

  def next_state(*args)
    execution.transition(*args)
  end

  def repeat
    next_state()
  end

  def wait!
    execution.wait
  end

  private

  def build_execution(context)
    @__execution = @__execution ? raise(AlreadyInExecutionError) : Execution.new(context)
  end

  def execution
    @__execution.required! { raise NotInExecutionError }
  end

  def flush_execution
    @__execution.tap { @__execution = nil }
  end

end
