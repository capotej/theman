require 'find'

ROOT = File.dirname(__FILE__)
Find.find(ROOT + '/workers') do |path|
  if path.include?('_worker') and !path.include?('~')
    God.watch do |w|
      w.name = File.basename(path).split('.')[0].gsub('_','-')
      w.interval = 30.seconds
      w.start = "ruby -I #{ROOT}/lib #{path}"
      w.start_if do |start|
        start.condition(:process_running) do |c|
          c.running = false
        end
      end
      w.behavior(:clean_pid_file)
    end
  end
end


