rocks = File.read('input.txt').split.map(&:to_i)
25.times do |i|
  new_rocks = []
  rocks.each do |rock|
    if rock == 0
      new_rocks << 1
    elsif rock.to_s.length.even?
      mid_index = rock.to_s.length / 2
      part1, part2 = rock.to_s[0...mid_index], rock.to_s[mid_index..-1]
      new_rocks << part1.to_i
      new_rocks << part2.to_i
    else
      new_rocks << rock * 2024
    end
  end

  rocks = new_rocks
end
puts rocks.count

# part2
rocks = File.read('input.txt').split.map(&:to_i)
cache = {}

def recursion(rock, blink, cache)
  cache_key = "#{rock}_#{blink}"

  if cache[cache_key]
    return cache[cache_key]
  end

  if blink == 0
    cache["#{rock}_#{blink}"] = 1
    return 1
  end

  if rock == 0
    cache["#{rock}_#{blink}"] = recursion(1, blink - 1, cache) if rock == 0
    return cache["#{rock}_#{blink}"]
  end

  if rock.to_s.length.even?
    mid_index = rock.to_s.length / 2
    part1, part2 = rock.to_s[0...mid_index], rock.to_s[mid_index..-1]
    cache["#{rock}_#{blink}"] = recursion(part1.to_i, blink - 1, cache) + recursion(part2.to_i, blink - 1, cache)
    return cache["#{rock}_#{blink}"]
  end

  cache["#{rock}_#{blink}"] = recursion(rock * 2024, blink - 1, cache)
  return cache["#{rock}_#{blink}"]
end

sum = 0
rocks.each do |rock|
  sum += recursion(rock, 75, cache)
end

puts sum