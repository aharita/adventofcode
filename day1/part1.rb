# frozen_string_literal: true

# https://adventofcode.com/2021/day/1

data = []

File.open('input.txt').each do |line|
  line = line.to_i
  data << line
end

incs = 0

(1..data.count - 1).each do |i|
  incs += 1 if data[i - 1] < data[i]
end

puts incs
