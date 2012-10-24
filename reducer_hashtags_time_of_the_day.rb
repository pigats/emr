#!/usr/bin/env ruby
# encoding: UTF-8

require 'json'

count = 0
hours = Hash.new(0)
key = ''

STDIN.each do |line|
  begin
    key, hour = line.split("\t")
    hour = hour.to_i
    count += 1
    hours[hour] += 1
    rescue Exception => e
    end
end

puts "#{key}\t#{count}||#{hours.to_s}"



