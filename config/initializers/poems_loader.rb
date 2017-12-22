require 'json'

poems = JSON.parse(File.open('./db/poems.json').read)
$level1_poems = {}
poems.each do |poem|
  poem[1].each do |string|
    $level1_poems[string.strip.gsub(/[[:punct:]]\z/, '')] = poem[0]
  end
end
