require "tmpdir"
TMP_DIR = Dir.tmpdir
USER_NAME = "onesup"
APP_NAME = "evezary"
APP_PATH = File.expand_path("/home/#{USER_NAME}/www/#{APP_NAME}/current")

root = "#{APP_PATH}"
working_directory root
pid "#{root}/tmp/pids/unicorn.pid"
stderr_path "#{root}/log/unicorn.err.log"
stdout_path "#{root}/log/unicorn.out.log"
 
# change the YOUR_APP_NAME to your application name
listen "#{TMP_DIR}/.unicorn.#{APP_NAME}.sock", :backlog => 512
# listen "/tmp/unicorn.coffee_letter.sock"
worker_processes 2
timeout 180
preload_app false
before_exec do |server|
  ENV["BUNDLE_GEMFILE"] = "#{root}/Gemfile"
end

before_fork do |server, worker|

  Signal.trap 'TERM' do
    puts 'Unicorn master intercepting TERM and sending myself QUIT instead'
    Process.kill 'QUIT', Process.pid
  end

  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.connection.disconnect!
end

after_fork do |server, worker|

  Signal.trap 'TERM' do
    puts 'Unicorn worker intercepting TERM and doing nothing. Wait for master to sent QUIT'
  end

  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.establish_connection
end