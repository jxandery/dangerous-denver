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

def find_top_neighborhoods(filename, x)
  crime_count = []
  records = create_records(filename)
  neighborhoods = records.group_by { |header| header[:neighborhood_id] }.values
  neighborhoods.each { |n| crime_count.push( [n.count, n.first[:neighborhood_id]] ) }
  crime_count.sort.reverse.first(x)
end

puts find_top_neighborhoods('crime', 5)

