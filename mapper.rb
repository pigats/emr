# encoding: UTF-8

require 'json'

STDIN.each do |line|
  begin
    tweet = JSON.parse line
    tweet['entities']['hashtags'].each do { |hashtag| puts "#{hashtag}\t1"
 }
  rescue Exception => e 
  end

end