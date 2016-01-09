require 'csv'
require 'benchmark'

def create_records(filename)
  beginning_time = Time.now
  records = []
  csv = CSV.open("../../data/#{filename}.csv", headers: true, header_converters: :symbol)
  csv.each do |line|
    records << line.to_h
  end

  end_time = Time.now
  puts "#{records.length} created"
  puts "Time elapsed #{(end_time - beginning_time)} seconds"
  records
end

def find_top_locations(filename, category, x)
  crime_count = []
  records = create_records(filename)
  neighborhoods = records.group_by { |header| header[category] }.values
  neighborhoods.each { |n| crime_count.push( [n.count, n.first[category]] ) }
  crime_count.sort.reverse.first(x)
end

puts find_top_locations('crime', :neighborhood_id, 5)
puts find_top_locations('traffic-accidents', :neighborhood_id, 5)
puts find_top_locations('traffic-accidents', :incident_address, 5)

