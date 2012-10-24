#!/usr/bin/env ruby
# encoding: UTF-8

require 'json'

STDIN.each do |line|
  begin
    hashtags = file.split("\n")
    hashtags.each do |hashtag|
      htag = hashtag.split("\t")
      key = htag[0].strip
      val = htag[1].to_i
      
      h = {key => val}
      temp_hash.merge!(h){|k,a,b|a+b}
    rescue Exception => e
    end

end

temp_hash.each {|k,v| final_array.push({"hashtag" => k, "count" => v}) if v >= min_count} 

File.open(json_file, 'w'){|f| f.write(final_array.to_json)}

