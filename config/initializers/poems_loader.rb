poems = JSON.parse(File.open('./db/poems.json') { |f| f.read })

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

$level6_poems = {}
poems.each do |poem|
  poem[1].each do |line|
    $level6_poems[line.gsub(/[[:punct:]]/, '').chars.sort.join] = line
  end
end

$level8_poems = []
lines = poems.map do |poem|
          poem[1]
        end.flatten
lines.uniq.each do |line|
  identifier = line.gsub(/[[:punct:]]/, '').chars

  if $level8_poems[identifier.size]
    $level8_poems[identifier.size][identifier] = line
  else
    $level8_poems[identifier.size] = {}
  end
end
