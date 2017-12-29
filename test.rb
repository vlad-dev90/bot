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
$level2_poems_2 = {}
poems.each do |poem|
  poem[1].each do |line|
    cline = rm_punc(line)
    s = 0
    cline.scan(/,? /) do
      e = $~.offset(0)[0]
      key = cline.clone
      key[s...e] = '%WORD%'
      $level2_poems_2[key] = cline[s...e]
      s = $~.offset(0)[1]
    end
    key = cline.clone
    key[s...cline.length] = '%WORD%'
    $level2_poems_2[key] = cline[s...cline.length]
  end
end
