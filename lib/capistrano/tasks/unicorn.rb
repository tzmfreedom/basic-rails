namespace :unicorn do
  task :start  do
    on roles(fetch(:unicorn_roles)) do
      within current_path do
        if test("[ -e #{fetch(:unicorn_pid)} ] && kill -0 #{pid}")
          info "unicorn is runnning with pid: #{pid}"
        else
          with rails_env: fetch(:rails_env) do
            unicorn_rack_env = fetch(:rails_env) == "development" ? "development" : "deployment"
            execute :bundle, "exec unicorn -c #{} -E #{unicorn_rack_env}"
          end
        end
      end
    end
  end

  task :stop do
    on roles(fetch(:unicorn_roles)) do
      within current_path do
        if test("[ -e #{fetch(:unicorn_pid)} ]")
          if test("kill -0 #{pid}")
            execute :kill, "-QUIT #{pid}"
          else
            execute :rm, pidfile
          end
        else
          info "unicorn is not runnning"
        end
      end
    end
  end

  task :reload do
    on roles(fetch(:unicorn_roles)) do
      within current_path do
        if test("[ -e #{fetch(:unicorn_pid)} ] && kill -0 #{pid}")
          execute :kill, "-HUP #{pid}"
        else
          info "unicorn is not runnning"
        end
      end
    end
  end

  task :restart do
    on roles(fetch(:unicorn_roles)) do
      within current_path do
        if test("[ -e #{fetch(:unicorn_pid)} ] && kill -0 #{pid}")
          execute :kill, "-USR2 #{pid}"
        else
          info "unicorn is not runnning"
        end
      end
    end
  end
end

def pidfile
  File.join(current_path, "tmp", "pids", "unicorn.pid")
end

def pid
  File.read(pidfile).to_i
end

def config_path
  File.join(current_path, "config", "unicorn", "#{fetch(:rails_env)}.rb")
end

after 'deploy:publishing', 'unicorn:restart'
