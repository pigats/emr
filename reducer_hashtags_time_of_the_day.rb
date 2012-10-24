#!/usr/bin/env ruby
# encoding: UTF-8

require 'json'

count = 0
hours = {}
key = ''
prev_key = nil

STDIN.each do |line|
  begin
    key, hour = line.split("\t")
    
    if key != prev_key 
      puts "#{prev_key}\t#{count}||#{hours.to_s}" unless prev_key.nil?
      count = 0
      hours = Hash.new(0)
      prev_key = key    
    end

    hour = hour.to_i
    count += 1
    hours[hour] += 1
    
    rescue Exception => e
    end
end
puts "#{prev_key}\t#{count}||#{hours.to_s}"



