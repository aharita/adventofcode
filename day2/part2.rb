# frozen_string_literal: true

# https://adventofcode.com/2021/day/2

horizontal = 0
depth = 0
aim = 0

File.open('input.txt').each do |line|
  split = line.split(' ')

  case split[0]
  when 'forward'
    horizontal += split[1].to_i
    depth += aim * split[1].to_i
  when 'up'
    aim -= split[1].to_i
  else
    aim += split[1].to_i
  end
end

puts horizontal * depth
