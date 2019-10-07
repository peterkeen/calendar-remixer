require './remixer'
require 'sinatra'

if ENV['CALENDARS']
  calendars = YAML.parse(ENV.fetch('CALENDARS'))
else
  calendars = YAML.load_file(ENV.fetch('CALENDARS_PATH', 'calendars.yaml'))
end

get '/:code/calendar.ics' do
  if params[:code] != ENV['SECURITY_CODE']
    status 404
    return ''
  end
  content_type 'text/calendar'
  Remixer.new(calendars).remix
end

