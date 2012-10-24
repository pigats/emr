#!/usr/bin/env ruby
# encoding: UTF-8

require 'json'
require 'time'

STDIN.each do |line|
  begin
    tweet = JSON.parse line
    normalized_hour = Time.at(Time.utc(tweet['created_at']).to_i - tweet['user']['utc_offset']).utc.hour
    tweet['entities']['hashtags'].each do |hashtag| 
      hashtag = hashtag['text'].downcase.strip      
      puts "#{hashtag}\t#{normalized_hour}"
    end

  rescue Exception => e
  end

end