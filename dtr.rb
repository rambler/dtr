#!/usr/bin/ruby

# depends on thread pool from http://burgestrand.se/code/ruby-thread-pool/
require_relative 'thread_pool'

p = Pool.new(8)
ctr = 0
ARGF.each do |l|
  i = ARGF.lineno
  p.schedule do
    puts "String job #{i} to run command \"#{l.chomp}\" by thread #{Thread.current[:id]}"
    system(l)
    puts "Job #{i} finished by thread #{Thread.current[:id]}"
  end
end

at_exit { p.shutdown }
