require 'listen'

listener = Listen.to('./lib', only: /\.rb$/) do |modified, added, removed|
  modified.each do |m|
    puts "[modified] [code] Reloading: #{m} - #{load(m)}"
  end
  added.each do |a|
    puts "[added] [code] Loading: #{a} - #{load(a)}"
  end
  puts "[removed] #{removed}" unless removed.empty?
end

listener.start # not blocking
#listener.only /\.(rb|yml)$/

require 'rake'

load 'Rakefile'
