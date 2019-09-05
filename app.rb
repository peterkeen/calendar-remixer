require './remixer'
require 'sinatra'

calendars = YAML.load_file('calendars.yaml')

get '/:code/calendar.ics' do
  if params[:code] != ENV['SECURITY_CODE']
    status 404
    return ''
  end

  Remixer.new(calendars).remix
end

