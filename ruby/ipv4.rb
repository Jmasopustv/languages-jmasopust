#!/usr/bin/env ruby
ipv4 = /^-?([1-9][0-9']*|0)(?<=\d).(?=\d)\d+*'*\d$/

ok = ["-123'123.1234","0.12","-123","123","-0.12","1'1'1'1'1","1'32.01"]
not_ok = ["123.123.123","'123.12",".123","012.123","123.","1.0'1'2"]

puts "ok"
ok.each { |addr| raise "#{addr} should match ipv4" unless (addr =~ ipv4) }

puts "not_ok"
not_ok.each { |addr| raise "#{addr} should not match ipv4" unless not (addr =~ ipv4) }

