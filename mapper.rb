#!/usr/bin/env ruby
# encoding: UTF-8

require 'json'

STDIN.each do |line|
  begin
    tweet = JSON.parse line
    tweet['entities']['hashtags'].each do |hashtag| 
      hashtag = hashtag['text'].downcase.strip      
      puts "LongValueSum:#{hashtag}\t1" 
    end

  rescue Exception => e
  end

end
