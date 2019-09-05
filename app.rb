require './remixer'
require 'sinatra'

calendars = YAML.load_file(ENV.fetch('CALENDARS_PATH', 'calendars.yaml'))

get '/:code/calendar.ics' do
  if params[:code] != ENV['SECURITY_CODE']
    status 404
    return ''
  end
  content_type 'text/calendar'
  Remixer.new(calendars).remix
end

