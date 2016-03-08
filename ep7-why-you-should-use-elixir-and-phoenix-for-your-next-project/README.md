# Why You Should Use Elixir and Phoenix for Your Next Project?

* Elixir borrowed lots of good ideas from Ruby
* Phoenix borrowed lots of good ideas from Rails thus reaching the critical mass of concepts needed to order to get stuff done is not antimidating
* Phoenix fixes lots of Rails issues

## Concurrency Model

### Processes and Messaging

### GenServer


## OTP (Open Telecom Platform)

In a time of starting monolithic and moving to micro-services, why not use a language who's tooling 
facilitates from the beginning of a project?

In Elixir, breaking a large application into smaller ones is simpler than anywhere else, as the process tree 
already outlines dependencies and the communication between those dependencies always happen explicitly via 
message passing. - Jose

### Umbrella Projects

Mix provides qa feature called umbrella projects where you have a project composed of many applications that may depend on 
each other on any fashion.

Umbrella projects allows you to compile, test and run each application as a unit but also perform all the tasks at once if 
required. 

### Applications

In Elixir (actually, in Erlang/OTP), an application is a component implementing some specific functionality, 
that can be started and stopped as a unit, and which can be re-used in other systems.

Elixir has an [Application module](http://elixir-lang.org/docs/stable/elixir/Application.html) for working with 
applications and defining application callbacks.

One can think of an application as a service that is running inside of the same (or another) BEAM instance.

### Supervisors

### Multiple Phoenix Applications

### Libraries

A library is a grouping of Elixir modules/functions that can be used in other libraries or applications.

Analagous to Ruby/Rails vendored gems.
  
    def deps do
      [
        {:some_lib, "~> 1.0", in_umbrella: true}
      ]
    end

### Oberserver

    :observer.start



## Functional Programming Style

### Pattern Matching

### Multi-Clause Functions

### Function Guards

### Pipe Operator
