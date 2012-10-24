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
      unless prev_key.nil?
        hours_string = hours.map {|v,k| "#{v}:#{k}"}.join(",")
        puts "#{prev_key}\t#{count}||#{hours_string}"
      end

      
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



