rows = IO.readlines("input.txt").map(&:chomp)

part1 = []
part2 = []
first = true
rows.each do |row|
  if row == ''
    first = false
    next
  end

  if first
    part1 << row
  else
    part2 << row
  end
end

# hashify
pages = Hash.new { |hash, key| hash[key] = [] }
part1.each do |row|
  parsed = row.split('|')
  pages[parsed[0]] << parsed[1]
end

sum = 0
incorrect = []
part2.each do |row|
  parsed = row.split(',')

  i = 0
  correct = true
  while i < parsed.length
    k = i + 1
    while k < parsed.length
      if pages[parsed[i]].include?(parsed[k])
      else
        correct = false
      end

      k += 1
    end

    i += 1
  end

  if correct
    sum += parsed[parsed.length/2].to_i
  else
    incorrect << parsed
  end

end
puts sum


sum = 0


incorrect.each do |row|
  while(true)
    i = 0
    correct = true
    while i < row.length
      k = i + 1
      while k < row.length
        if pages[row[i]].include?(row[k])
        else
          correct = false
          row[i], row[k] = row[k], row[i]
        end

        k += 1
      end

      i += 1
    end

    if correct
      sum += row[row.length/2].to_i
      break
    else
    end
  end
end
puts sum