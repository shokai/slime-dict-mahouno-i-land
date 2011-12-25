#!/usr/bin/env ruby
require 'jcode'

def mecab_parse(line)
  line.split(/\t/).map{|i|
    i.split(/,/)
  }.flatten
end

ARGF.each do |line|
  line.strip!
  next if line == 'EOS'
  next if line.size < 1
  parsed = mecab_parse(line)

  surface = parsed[0]
  next unless surface
  next if surface =~ /^[ぁ-ん]+$/ # ひらがなのみ
  next if surface =~ /^[ァ-ン]$/ # カタカナ1文字だけ

  kana = parsed[8]
  next unless kana
  kana = kana.tr('ァ-ン','ぁ-ん') ## 読み
  type = parsed[1]
  next unless type
  puts "#{kana} #{surface} [#{type}]"
end
