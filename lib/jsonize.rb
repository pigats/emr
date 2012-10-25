#!/usr/bin/env ruby
# encoding: UTF-8

require 'json'


data_file = ARGV[0] rescue nil
json_file = ARGV[1] rescue nil
cut = ARGV[2] rescue nil

unless data_file || json_file
  puts "usage: ./jsonize.rb <inputfile> <outputfile> <minimum count>"
  exit()
end


min_count = cut || 100
min_count = min_count.to_i

final_array = []

file = File.read(data_file)
hashtags = file.split("\n")
hashtags.each do |hashtag|
  htag = hashtag.split("\t")
  key = htag[0].strip
  count, hours = htag[1].split('||')
  count = count.to_i
  hours_count = []
  hours_array = []
  hours.split(',').each do |c| 
    h, h_c = c.split(':') 
    hours_array[h.to_i] = h_c.to_i
  end

  if count >= min_count 
    (0..23).each do |hour|

      hours_count.push ({ hour: hour, count: hours_array[hour] || 0 })
      # {hashtag: 'egypt',
      #  count: 5,
      #  hours_count: 
      #   [{
      #     hour: 21,
      #     count: 5
      #   }]
      # }
    end
    final_array.push ({hashtag: key, count: count, hours_count: hours_count})
  end
end

File.open(json_file, 'w'){|f| f.write(final_array.to_json)}