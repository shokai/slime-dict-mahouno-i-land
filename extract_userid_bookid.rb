#!/usr/bin/env ruby

users = Hash.new{|h,k| h[k] = Hash.new(0)}

ARGF.each do |url|
  url.strip!
  params = Hash.new
  url.split('.asp?').last.split(/(&|%26)/).each{|kv|
    k,v = kv.split('=').map{|i| i.downcase}
    params[k] = v if k.to_s.size > 0 and v.to_s.size > 0
  }
  user = params['i']
  book = params['bookid']
  users[user][book] += 1
end

users.keys.sort.each do |user|
  users[user].keys.sort.each do |book|
    puts "#{user} : #{book}"
  end
end
