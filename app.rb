require './remixer'
require 'rufus-scheduler'
require 'sinatra/base'

class RemixerApp < Sinatra::Base
  def initialize
    super

    @rendered_calendar = ""

    if ENV['CALENDARS']
      @calendars = YAML.load(ENV.fetch('CALENDARS'))
    else
      @calendars = YAML.load_file(ENV.fetch('CALENDARS_PATH', 'calendars.yaml'))
    end

    scheduler = Rufus::Scheduler.new
    scheduler.every '5m', first_in: '1s' do
      puts "Rendering calendar..."
      @rendered_calendar = Remixer.new(@calendars).remix
      puts "Done rendering calendar!"
    end
  end

  get '/:code/calendar.ics' do
    if params[:code] != ENV['SECURITY_CODE']
      status 404
      return ''
    end

    content_type 'text/calendar'

    @rendered_calendar
  end

  run! if app_file == $0
end

