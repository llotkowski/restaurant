namespace :deploy do
  desc "Symlink shared 'config' and 'db' folders on each release."
  task :symlink_shared, :role => :web do
    run "mkdir -p #{shared_path}/{config,db,doc}"
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    run "ln -nfs #{shared_path}/doc #{release_path}/public/doc"
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
after "deploy:update_code", "mongrel:cluster:configure"
after 'deploy:update_code', "deploy:database"
after 'deploy:update_code', "deploy:mongrel_conf"
