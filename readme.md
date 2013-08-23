# Dominion Engine

## State machines and Stack machines

### State Machines

State machines exist in a state, and on execution, may do one of the following:

1. Transition to another state
2. Complete, popping this state machine off of the stack, and possibly returning an output
3. Hold, remaining in the same state — this is the default behavior

So #step can return one of:

1. An output (like the response from a menu)
2. A display (like a menu itself)
4. A notice that this machine is completed

Does it return, or does it modify the context?  I think it modifies the context.

### Stack Machines

Stack machines exist in a stack of states.  On execution, may do one of the following:

1. Nothing – the current state pops off of the stack.  This is the default behavior
2. Transition – the current state pops off of the stack, and a new state takes its place
  It can push several states onto the stack at once.

### Behaviors

Behaviors are object that have the state behavior used by the machines above.  A behavior object needs to implement an #initial_state method to specify the state if none is given.

### Stack/State Machines

Not sure about this.

4. Jump, pushing execution of another state machine onto the stack
3. A new behavior to stack on top of this one
