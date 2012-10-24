#!/usr/bin/env ruby
# encoding: UTF-8

require 'json'


data_file = ARGV[0] rescue nil
json_file = ARGV[1] rescue nil
cut = ARGV[2].to_i rescue nil

unless data_file || json_file
  puts "usage: ./jsonize.rb <inputfile> <outputfile> <minimum count>"
  exit()
end

min_count = cut || 100
final_array = []
temp_hash = {}

file = File.read(data_file)
hashtags = file.split("\n")
hashtags.each do |hashtag|
  htag = hashtag.split("\t")
  key = htag[0].strip
  val = htag[1].to_i
  
  h = {key => val}
  temp_hash.merge!(h){|k,a,b|a+b}
end

temp_hash.each {|k,v| final_array.push({"hashtag" => k, "count" => v}) if v >= min_count} 

File.open(json_file, 'w'){|f| f.write(final_array.to_json)}
