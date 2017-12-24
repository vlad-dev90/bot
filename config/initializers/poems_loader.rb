require 'json'

poems = JSON.parse(File.open('./db/poems.json').read)

$level1_poems = {}
poems.each do |poem|
  poem[1].each do |line|
    $level1_poems[line.strip.gsub(/[[:punct:]]\z/, '')] = poem[0]
  end
end

$level2_poems = ''
poems.each do |poem|
  poem[1].each do |line|
    $level2_poems << line + "\n"
  end
end

$level5_poems = ''
poems.each do |poem|
  poem[1].each do |line|
    $level5_poems << line.strip.gsub(/[[:punct:]]\z/, '') + "\n"
  end
end
