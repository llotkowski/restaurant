set :user, "mjunski"

# If you aren't deploying to /u/apps/#{application}
# on the target servers (which is the default),
# you can specify the actual location
# via the :deploy_to variable:

set :application, "restaurant"
set :deploy_to, "/home/inf/mjunski/www/#{application}"

# --- git

set :repository, "git://github.com/llotkowski/restaurant.git"
set :scm, :git
set :branch, "master"
set :deploy_via, :export

# -- capistrano

set :use_sudo, false

role :app, "manta.univ.gda.pl"
role :web, "manta.univ.gda.pl"
role :db,  "manta.univ.gda.pl", :primary => true

set :keep_releases, "4"  # cap deploy:cleanup
