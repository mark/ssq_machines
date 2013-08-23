module SsqMachines; end

require 'ssq_machines/transition'
require 'ssq_machines/frame'
require 'ssq_machines/execution'
require 'ssq_machines/behavior'
require 'ssq_machines/base_machine'
require 'ssq_machines/state_machine'
require 'ssq_machines/stack_machine'
require 'ssq_machines/queue_machine'

class Object
  def required!
    nil? ? yield : self
  end
end
