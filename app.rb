require './remixer'
require 'sinatra'
require 'sinatra/streaming'

if ENV['CALENDARS']
  calendars = YAML.load(ENV.fetch('CALENDARS'))
else
  calendars = YAML.load_file(ENV.fetch('CALENDARS_PATH', 'calendars.yaml'))
end

get '/:code/calendar.ics' do
  if params[:code] != ENV['SECURITY_CODE']
    status 404
    return ''
  end

  content_type 'text/calendar'

  stream do |out|
    out.write("\n")
    out.write(Remixer.new(calendars).remix)
  end
end

