# frozen_string_literal: true
# https://adventofcode.com/2023/day/8

pattern = nil
mapping = {}
File.open('example.txt').each_with_index do |line, index|
  pattern = line.strip if index.zero?
  next if index <= 1

  node_value = line.split('=')[0].strip
  left_value = line.split('=')[1].strip[1..-1].split(',')[0].strip
  right_value = line.split('=')[1].strip[1..-2].split(',')[1].strip

  mapping[node_value] = [left_value, right_value]
end

roads = {}
mapping.each do |k, v|
  current_node = k

  pattern.each_char do |char|
    if roads[k] == nil
      roads[k] = []
    end

    if char == 'L'
      roads[k] << mapping[current_node][0]
      current_node = mapping[current_node][0]
    else
      roads[k] << mapping[current_node][1]
      current_node = mapping[current_node][1]
    end
  end
end

current_node = 'AAA'
steps = 0
seen = {}

while true

  break if current_node == 'ZZZ'

  if roads[current_node].include?('ZZZ')
    roads[current_node].each do |value|
      steps += 1
      break if value == 'ZZZ'
    end
    break
  else
    steps += roads[current_node].count
  end

  current_node = roads[current_node].last
end

puts steps
