#!/usr/bin/env ruby
# encoding: UTF-8

require 'json'

STDIN.each do |line|
  begin
    tweet = JSON.parse line
    tweet['entities']['hashtags'].each do |hashtag| 
      hashtag = hashtag['text'].downcase.strip      
      hashtag = hashtag[0...(hashtag.length*0.8).to_f.floor] if hashtag.length > 3 # stemming-of-the-poors
      puts "LongValueSum:#{hashtag}\t1" 
    end

  rescue Exception => e
  end

end