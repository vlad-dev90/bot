require 'json'
require 'benchmark'

fh = {'а' => 2, 'б' => 1 }.to_a
sh = {'а' => 1, 'б' => 2 }.to_a
fs = 'ааб'.chars
ss = 'абб'.chars

Benchmark.bmbm do |x|
  x.report("array with numbers") { 30000.times { fh - sh } }
  x.report("array with letters")  { 30000.times { fs - ss } }
end
