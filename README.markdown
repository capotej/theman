# theman

theman is a super simple "framework" that uses god/rufus-scheduler to create long running workers that do things at certain times.

## Installing theman

theman is easy to get running, it doesn't have any other dependences other than god and rufus/scheduler.

       git clone git://github.com/jcapote/theman.git
       cd theman
       god -c boot.god -D

This will start all the workers that have _worker.rb appended to them in the workers directory.

## Writing your own workers

A worker is nothing more than a ruby script that requires 'worker', subclasses Worker, and lives in the worker directory with _worker.rb in the name. This is an example worker:

       require 'worker'

       class ExampleWorker < Worker

         def start
           logger "starting task"
         end

         every "5s", :start

       end


It looks like a regular ruby class, except towards the bottom we have a line were we specify when and what to run. For all the possible commands take a look at workers/example_worker.rb

Note: make sure your when/what line is at the *bottom* of your class


## Running workers manually (and regardless of time definition)

Sometimes it's useful to run a worker right now as opposed to when it's supposed to run, to do this just run the worker manually with the "now" argument:
	  
       ruby -I lib/ workers/example_worker.rb now




