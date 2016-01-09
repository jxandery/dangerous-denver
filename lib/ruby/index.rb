require 'csv'
require 'benchmark'

def mark_time(search, search_name)
  beginning_time = Time.now
  search
  end_time = Time.now
  puts "#{search_name} completed in #{(end_time - beginning_time)} seconds"
end

def parse_csv(filename)
  records = []
  csv = CSV.open("../../data/#{filename}.csv", headers: true, header_converters: :symbol)
  csv.each { |line| records << line.to_h }
  records
end

def find_top_locations(filename, category, x)
  crime_count = []
  records = parse_csv(filename)
  neighborhoods = records.group_by { |header| header[category] }.values
  neighborhoods.each { |n| crime_count.push( [n.count, n.first[category]] ) }
  puts crime_count.sort.reverse.first(x)
end

parse_crime       = parse_csv('crime')
parse_accidents   = parse_csv('traffic-accidents')
crime             = find_top_locations('crime', :neighborhood_id, 5)
accidents         = find_top_locations('traffic-accidents', :neighborhood_id, 5)
dangerous_corners = find_top_locations('traffic-accidents', :incident_address, 5)

mark_time(parse_accidents, 'Read accidents CSV')
mark_time(parse_crime, 'Read crime CSV')
mark_time(crime, 'Top crime locations search')
mark_time(accidents, 'Top accidents locations search')
mark_time(dangerous_corners, 'Most dangerous corners locations search')

