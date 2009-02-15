require 'worker'

class AnotherWorker < Worker
  def whatever
    logger("another worker")
  end

  every "5s", :whatever

end
