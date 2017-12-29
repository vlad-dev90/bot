def rm_punc(line)
  line.strip.gsub(/[[:punct:]]\z/, '')
end
poems = JSON.parse(File.open('./db/poems.json') { |f| f.read }).uniq

$level1_poems = {}
poems.each do |poem|
  poem[1].each do |line|
    $level1_poems[line.gsub(/[[:punct:]]\z/, '').strip] = poem[0]
  end
end

$level2_poems_2 = {}
poems.each do |poem|
  poem[1].each do |line|
    words = line.split(/\s/)
    words.each do |word|
      $level2_poems_2[rm_punc(line).sub(rm_punc(word), '%WORD%')] = rm_punc(word)
    end
  end
end

$level3_poems = {}
poems.each do |poem|
  poem[1].each do |line|
    words = line.split(/\s/)
    words.each do |word|
      $level3_poems[line.sub(rm_punc(word), '%WORD%')] = rm_punc(word)
    end
  end
end

$level5_poems= {}
poems.each do |poem|
  poem[1].each do |line|
    cline = rm_punc(line).strip
    s = 0
    cline.scan(/,? /) do
      e = $~.offset(0)[0]
      key = cline.clone
      key[s...e] = '%WORD%'
      $level5_poems[key] = cline[s...e]
      s = $~.offset(0)[1]
    end
    key = cline.clone
    key[s...cline.length] = '%WORD%'
    $level5_poems[key] = cline[s...cline.length]
  end
end

$level6_poems = {}
lines = poems.map do |poem|
          poem[1]
        end.flatten
lines.uniq.each do |line|
  $level6_poems[line.gsub(/[[:punct:]]/, '').chars.sort.join] = line
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
