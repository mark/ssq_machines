require 'ssq_machines/behavior'
require 'ssq_machines/frame'

class SsqMachines::BaseMachine
  
  class CompletedMachineExecution < StandardError; end

  ####################
  #                  #
  # Instance Methods #
  #                  #
  ####################

  def add(behavior, state = nil)
    add_state SsqMachines::Frame.new(behavior, state)
  end

  def completed?
    raise NotImplementedError
  end

  def run(context)
    wait(false)

    until completed? || waiting?
      step(context)
    end
  end

  def step(context)
    raise CompletedMachineExecution if completed?

    execution = next_state.execute(context)

    add_states execution.transitions
    wait       execution.waiting
  end

  private

  def add_state(state)
    raise NotImplementedError
  end

  def add_states(transitions)
    transitions.each { |transition| add_state(transition) }
  end

  def next_state
    raise NotImplementedError
  end

  def wait(should_wait)
    @waiting = should_wait
  end

  def waiting?
    @waiting
  end

end
