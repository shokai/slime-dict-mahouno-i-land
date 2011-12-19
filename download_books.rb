#!/usr/bin/env ruby
require 'rubygems'
require 'open-uri'
require 'kconv'
require 'nokogiri'

## config
data_dir = File.dirname(__FILE__)+'/data'
interval = 3

Dir.mkdir data_dir unless File.exists? data_dir

## 本の全ページのURLを返す
def book_pages(url)
  page = open(url).read.toutf8
  first_url = page.scan(/(http:\/\/.*tosp\.co\.jp\/[^\s\r\n\"\']+)/).
    flatten.uniq.detect{|u|
    u =~ /SPA=\d+/ and u =~ /TP=1/
  }
  last = page.scan(/全(\d+)ページ/).first.first.to_i
  if first_url.to_s.size < 1 or last < 1
    return []
  else
    return 1.upto(last).map{|i|
      first_url.gsub('TP=1',"TP=#{i}")
    }
  end
end

## ページの本文を抜き出す
def extract_body(page)
  begin
    html = page.gsub(/[\r\n]/,'').scan(/<div class="content">(.+)<\/div>/i).first.first.
      split(/<\/div>/i).first.gsub(/<br>/i,"\n")
    return Nokogiri::HTML(html).inner_text
  rescue
    return nil
  end
end

ARGF.each do |url|
  book_pages(url).each{|permalink|
    puts permalink
    fname = "#{data_dir}/#{permalink.gsub(/\//,'_')}"
    if !File.exists?(fname) or File.stat(fname).size < 1
      puts body = extract_body(open(permalink).read.toutf8)
      open(fname,'w+') do |out|
        out.puts body
      end
      sleep interval
    end
  }
  sleep interval
end
