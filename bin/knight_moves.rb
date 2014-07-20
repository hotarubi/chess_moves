#!/usr/bin/env ruby
# encoding: UTF-8
unless /^(1\.9|2)/ =~ RUBY_VERSION
  puts "Ruby version is too low!"
  exit
end

require File.expand_path("../../lib/knight_move", __FILE__)

input = (ARGV.empty? ? gets.split(' ') : ARGV).map(&:chomp)
convert = lambda do |str|
  pts = str.split('')
  [ pts[0], pts[1].to_i ]
end

unless input.length == 2 && input.all? {|a| /^[a-z]\d+$/ =~ a }
  puts "Invalid input! (#{input.join(', ')})"
  exit
end

begin
  puts KnightMove.new(
    [ convert.call(input[0]) ],
    convert.call(input[1])
  ).to_target
rescue Move::OutOfChessboard, Move::InvalidTarget => e
  puts e.message
end
