#!/usr/bin/env ruby
require 'rubygems'
require 'igo-ruby'
require 'jcode'

begin
  igo = Igo::Tagger.new(File.dirname(__FILE__)+'/ipadic')
rescue => e
  STDERR.puts 'mecab error'
  STDERR.puts e
  exit 1
end

ARGF.each do |line|
  igo.parse(line.strip).each do |i|
    next if i.surface =~ /^[ぁ-ん]+$/ # ひらがなのみ
    next if i.surface =~ /^[ァ-ン]$/ # カタカナ1文字だけ
    splited = i.feature.split(',')
    type = splited[0] ## 品詞
    kana = splited[-2].tr('ァ-ン','ぁ-ん') ## 読み
    next if kana == i.surface
    next if kana =~ /[\[\]「」\*]/
    puts "#{kana} #{i.surface} [#{type}]"
  end
end
