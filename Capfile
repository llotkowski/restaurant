load 'deploy' if respond_to?(:namespace) # cap2 differentiator
Dir['vendor/plugins/*/recipes/*.rb'].each { |plugin| load(plugin) }

load 'config/deploy'    # automatycznie wygenerowany wiersz
load 'lib/cap_recipes'  # definicja bazy danych i pliku mongrela
