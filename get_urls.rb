#!/usr/bin/env ruby
require 'rubygems'
require 'open-uri'
require 'nokogiri'
require 'kconv'
require 'pp'

depth = ARGV.shift.to_i
depth = 3 if depth < 1
puts "* depth:#{depth}"

START = 'http://tosp.co.jp/p.asp?i=MAHOBOOK'
CRAWL = 
TARGET = /https?:\/\/.*tosp\.co\.jp\/BK\/TosBK100\.asp\?.*BookId=\d+/i

def get_urls(url)
  open(url).read.toutf8.scan(/(http:\/\/.*tosp\.co\.jp\/[^\s\r\n\"\']+)/).flatten.uniq
end

def get_urls_r(url, r=2)
  return url if r < 1
  sleep 1
  puts "* get_url #{url}"
  get_urls(url).map{|u|
    get_urls_r(u, r-1)
  }.flatten.uniq
end

get_urls_r(START, depth).delete_if{|url|
  !(url =~ TARGET)
}.each{|url|
  puts url
}
