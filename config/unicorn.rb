listen 5000
worker_processes 2
pid File.expand_path("../../tmp/pids/unicorn.pid", __FILE__)
timeout 10

# stderr_path File.expand_path("../../log/unicorn_stderr.log", __FILE__)
# stdout_path File.expand_path("../../log/unicorn_stdout.log", __FILE__)

preload_app true

before_fork do |server, worker|
  defined?(ActiveRecord::Base) and ActiveRecord::Base.connection.disconnect!

  old_pid = "#{server.config[:pid]}.oldbin"
  if old_pid != server.pid
    begin
      sig = (worker.nr + 1) >= server.worker_processes ? :QUIT : :TTOU
      Process.kill(sig, File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH => e
      puts e.message
      puts e.backtrace
    end
  end
end

after_fork do |server, worker|
  defined?(ActiveRecord::Base) and ActiveRecord::Base.establish_connection
end
