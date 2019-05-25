#!/usr/bin/env ruby

require 'rmeetup'

client = RMeetup::Client.new do |config|
  config.api_key = ENV['MEETUP_API']
end

groups = %w[
  sawebdev
  SanAntonioWordPress
  ReactSA
  San-Antonio-PHP-Meetup
  Alamo-City-Python-Group
  San-Antonio-Java-User-Group
  San-Antonio-PowerShell-User-Group
  10BitWorks-Meetup
  Dinner-and-Code-San-Antonio
  San-Antonio-Cyber-Security-for-Control-Systems
  San-Antonio-iOS-Developer-Meetup
  SATNUG
  sarubycoders
  Kubernetes-San-Antonio
  San-Antonio-JavaScript-User-Group
  OWASP-San-Antonio
  San-Antonio-League-of-SQL-Server-Administrtors-SALSSA
  Operation-Code-San-Antonio
  UI-UX-Meetup
  San-Antonio-Android-Application-Development-Meetup
  SAGEgroup
  Alamo-City-R-Users-Group
  SanAntonioDevOps
  San-Antonio-Elastic-Fantastics
  San-Antonio-Data-Science-Meetup
  cyberdefdojo
  OEC-Technology
  San-Antonio-Code-Newbies
  LiskCommunityJavaScriptWorkshop
  Artificial-Intelligence-and-Machine-Learning-of-San-Antonio
  San-Antonio-Women-Developers
  Code-for-San-Antonio
  San-Antonio-Linux-Enthusiasts
]

group_counts = {}

groups.each do |group|
  results = client.fetch(
    :events,
    group_urlname: group,
    status: 'past'
  )

  results.each do |result|
    if result.yes_rsvp_count > 30 && result.time.to_date > Date.new(2018, 1, 1)
      group_counts[group] ||= 0
      group_counts[group] += 1
      puts "#{group}: #{result.time.to_date}, #{result.yes_rsvp_count}"
    end
  end
end

puts group_counts
