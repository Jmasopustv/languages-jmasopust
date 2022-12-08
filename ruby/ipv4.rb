#!/usr/bin/env ruby
ipv4 = /^-?[1-9](\d+|'\d+)('?\d+).?\d+('?\d+)$/

ok = ["-123'123.123","123'123.123","123123.123","123'1'23.12'3"]
not_ok = ["123.123.123","0.123",".123"]

puts "ok"
ok.each { |addr| raise "#{addr} should match ipv4" unless (addr =~ ipv4) }

puts "not_ok"
not_ok.each { |addr| raise "#{addr} should not match ipv4" unless not (addr =~ ipv4) }

