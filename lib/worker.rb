require 'rubygems'
require 'rufus/scheduler'
require 'logger'

ROOT = File.dirname(__FILE__) + "/.."

class Worker
      
  def self.inherited(subclass)
    @@log = Logger.new(ROOT + "/log/#{subclass}.log")
    @@sched = Rufus::Scheduler.start_new
    @@klass = subclass
  end

  def logger(str)
    @@log.info(str)
  end

  def self.start_in(str, m)
    self.schedule(:schedule_in, str, m)
  end

  def self.cron(str, m)
    self.schedule(:cron, str, m)
  end

  def self.every(str, m)
    self.schedule(:every, str, m)
  end

  def self.schedule(cmd, arg, m)
    caller = Proc.new { obj = @@klass.new; obj.send(m.to_sym) }
    @@sched.send cmd, arg, &caller
    @@sched.join
  end


end
