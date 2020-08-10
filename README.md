# Calendar Remixer

This is a ruby app that consumes one or more iCal calendars, remixes them, and republishes a single feed.

[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy)

## Calendars YAML Format

Calendars to remix are specified using YAML. You can either set this directly using the `CALENDARS` environment variable or set the `CALENDARS_PATH` environment variable to point to a path, default to `calendars.yaml` in the current directory.

Here's an example:

```yaml
- url: 'https://example.com/calendar.ics'
  summary: 'Meetings'
  skip: '(Out Of Office|OOO)'
- url: 'https://example.com/another_calendar.ics'
  summary: 'On Call',
```

The allowed options are:

* `url` specifies the URL to the calendar feed. This must be accessible from whereever you're deploying the app to.
* `summary` overrides the `summary` field of each calendar event. This is the event name. All other fields in the calendar entry will be stripped.
* `skip` specifies a regular expression to use for skipping events. The regular expression will match against the event summary field.

## Accessing the Remixed Calendar

The remixed calendar is available at this path:

```
/SECURITY_CODE/calendar.ics
```

where `SECURITY_CODE` is the value of the `SECURITY_CODE` environment variable.
