namespace :deploy do
  desc "Symlink shared 'config' and 'db' folders on each release."
  task :symlink_shared, :role => :web do
    run "mkdir -p #{shared_path}/{config,db,doc}"
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    run "ln -nfs #{shared_path}/doc #{release_path}/public/doc"
  end

  desc "Copy database.yml file and move it to the 'shared_path' directory."
   task :database, :role => :web do
     database_conf = <<-CMD
 # SQLite version 3.x
#  gem install sqlite3-ruby (not necessary on OS X Leopard)
development:
  adapter: sqlite3
  database: db/development.sqlite3
  pool: 5
  timeout: 5000

# Warning: The database defined as "test" will be erased and
# re-generated from your development database when you run "rake".
# Do not set this db to the same as development or production.
test:
  adapter: sqlite3
  database: db/test.sqlite3
  pool: 5
  timeout: 5000

production:
  adapter: sqlite3
  database: db/production.sqlite3
  pool: 5
  timeout: 5000
     CMD
     put database_conf, "#{shared_path}/config/database.yml"
   end

  desc "Create the mongrel.conf file and move it to the 'shared_path' directory."
   task :mongrel_conf, :role => :web do
     mongrel_conf = <<-CMD
 DirHandler.add_mime_type(".rb", "text/plain; charset=UTF-8")
 DirHandler.add_mime_type(".yml", "text/plain; charset=UTF-8")
 dir_handler = DirHandler.new("#{current_path}/public/doc")
 uri "/doc", :handler => dir_handler
     CMD
     put mongrel_conf, "#{shared_path}/config/mongrel.conf"
   end

end
  # -- run hooks
after 'deploy:update_code', "deploy:symlink_shared"
#after "deploy:update_code", "mongrel:cluster:configure"
after 'deploy:update_code', "deploy:database"
after 'deploy:update_code', "deploy:mongrel_conf"
