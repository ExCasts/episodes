# What is a GenServer?

* An OTP abstraction for implementing an Elixir or Erlang process
* Ensures a consistent API
* Can be used in OTP supervision trees
* Ensures best practices developed over years of Erlang system implementations


# When Should I Use a GenServer?

Anytime you need to employ a long-lived Elixir process and a higher level abstraction (ie.
GenEvent, Agent, Task, etc) you should consider using the GenServer behavior.
