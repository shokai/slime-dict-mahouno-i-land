#!/usr/bin/env ruby

ARGF.each do |line|
  line.strip!
  user, book = line.split(':').map{|i| i.strip}
  puts "http://tosp.co.jp/BK/TosBK100.asp?I=#{user}&BookId=#{book}"
end
