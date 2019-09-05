require 'rubygems'
require 'capistrano-buildpack'

set :normalize_asset_timestamps, false
set :application, "ledger-app"
set :repository, "git@git.zrail.net:peter/calendar-remixer.git"
set :scm, :git
set :additional_domains, ['calendar-remixer.petekeen.net']
set :use_sudo, true

role :web, "kodos.zrail.net"
set :buildpack_url, "git@git.zrail.net:peter/bugsplat-buildpack-ruby-shared"

set :user,        "peter"
set :concurrency, "web=1"
set :base_port,   8300
set :use_ssl, true
set :force_ssl, true
set :listen_address, '10.248.9.84'
set :foreman_export_path, "/lib/systemd/system"
set :foreman_export_type, "systemd"

set :ssl_cert_path, '/etc/nginx/certificates/site-3/fullchain.pem'
set :ssl_key_path, '/etc/nginx/certificates/site-3/privkey.pem'

read_env 'prod'

load 'deploy'

after :deploy do
  top.upload('calendars.yaml', 'calendars.yaml')
end
