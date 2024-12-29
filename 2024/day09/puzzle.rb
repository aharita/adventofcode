def dots_counter_calc(expand)
  dots_counter = Hash.new(0)

  index = -1
  while index < expand.length
    index += 1
    times = 0
    first_index = 0

    if expand[index] == '.'
      first_index = index
    end

    while expand[index] == '.'
      times += 1
      index += 1
    end

    dots_counter[first_index] = times if times > 0
  end

  dots_counter
end

input = File.read('input.txt').strip
#input = "2333133121414131402"

dots_counter = Hash.new(0)
number_counter = Hash.new(0)
expand = []
index = 0
input.chars.each_with_index do |char, char_index|
  if char_index.odd?
    expand.concat(['.'] * char.to_i)
    dots_counter[expand.length - char.to_i] += char.to_i
  else
    expand.concat([index] * char.to_i)
    number_counter[index] += char.to_i
    index += 1
  end
end

expand2 = expand.dup

# part1
left = 0
right = expand.length - 1
while left < right
  left += 1 while left < right && expand[left] != '.'
  right -= 1 while left < right && expand[right] == '.'

  expand[left], expand[right] = expand[right], expand[left]
  left += 1
  right -= 1
end

sum = 0
expand.each_with_index do |char, index|
  next if char == '.'
  sum += index * char.to_i
end
puts sum

# part2
expand2_indexes = Hash.new(0)
number_counter.keys.each do |key|
  expand2_indexes[key] = expand2.index(key)
end

number_counter.shift
number_counter.keys.reverse.each do |key|
  dots_counter = dots_counter_calc(expand2)

  dots_counter.each do |dots_index, dots_times|
    if dots_times >= number_counter[key] && expand2_indexes[key] > dots_index
      start_index = dots_index
      end_index = start_index + number_counter[key] - 1
      expand2.map! { |char| char == key ? '.' : char }

      while start_index <= end_index
        expand2[start_index] = key
        start_index += 1
      end

      break
    end
  end
end

sum = 0
expand2.each_with_index do |char, index|
  next if char == '.'
  sum += index * char.to_i
end
puts sum
