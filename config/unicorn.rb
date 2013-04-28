worker_processes Integer(ENV["WEB_CONCURRENCY"] || 3)
timeout 15
preload_app true

before_fork do |server, worker|

  defined?(DB) and DB.disconnect

  Signal.trap 'TERM' do
    puts 'Unicorn master intercepting TERM and sending myself QUIT instead'
    Process.kill 'QUIT', Process.pid
  end

end

after_fork do |server, worker|

  if defined?(Sequel)
    DB = Sequel.connect(ENV['HEROKU_POSTGRESQL_AMBER_URL'] || 'postgres://localhost/mc_markdown')
  end

  Signal.trap 'TERM' do
    puts 'Unicorn worker intercepting TERM and doing nothing. Wait for master to send QUIT'
  end

end