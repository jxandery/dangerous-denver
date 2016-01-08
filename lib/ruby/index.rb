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

create_records("crime")
