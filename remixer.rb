require 'icalendar'
require 'httparty'
require 'pp'
require 'digest'

class Remixer
  def initialize(calendars)
    @calendars = calendars
  end

  def remix
    new_cal = Icalendar::Calendar.new
    @calendars.each do |calendar_options|
      url = calendar_options['url']

      fetched = HTTParty.get(url)
      
      parsed = Icalendar::Calendar.parse(fetched)

      parsed.each do |cal|
        cal.events.each do |event|
          if calendar_options['skip']
            next if event.summary =~ /#{calendar_options['skip']}/i
          end

          event.summary = calendar_options['summary']
          event.organizer = nil
          event.description = nil
          event.location = nil
          event.attendee = nil
          event.url = nil
          
          new_cal.add_event(event)
        end
      end
    end

    new_cal.to_ical
  end
end
