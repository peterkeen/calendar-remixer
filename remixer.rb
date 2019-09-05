require 'icalendar'
require 'httparty'
require 'pp'

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
          new_event = Icalendar::Event.new
          new_event.dtstart = event.dtstart
          new_event.dtend = event.dtend
          new_event.uid = event.uid
          new_event.summary = calendar_options['summary']
          
          new_cal.add_event(new_event)
        end
      end
    end

    new_cal.to_ical
  end
end
