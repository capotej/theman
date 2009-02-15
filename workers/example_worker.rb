require 'worker'

class ExampleWorker < Worker

  def start
    logger "starting task"
    self.get_to_work
  end

  def get_to_work
    result = 2 + 2
    logger "executed #{result}"
  end

  #Examples:
  #  in "30m", :start
  #  cron "31 * * * * *", :start

  every "2s", :start
end


