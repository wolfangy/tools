# Grok

## Generic Grok Syntax

`%{PATTERN:identifier}`

example to email:
`%{EMAILADDRESS:client_email}`

example to log:
`%{TIMESTAMP_ISO8601:time} %{LOGLEVEL:logLevel} %{GREEDYDATA:logMessage}`
 To match:
 `2020-07-16T19:20:30.45+01:00 DEBUG This is a sample log`

## Grok Debug Tool:

[The Grok Debug Tool](grokdebug.herokuapp.com/)
