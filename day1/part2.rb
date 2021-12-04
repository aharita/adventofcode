# frozen_string_literal: true

# https://adventofcode.com/2021/day/1

data = []

File.open('input.txt').each do |line|
  line = line.to_i
  data << line
end

incs = 0

(0..data.count).each do |index|
  break if data[index + 3].nil?

  w1 = data[index] + data[index + 1] + data[index + 2]
  w2 = data[index + 1] + data[index + 2] + data[index + 3]

  incs += 1 if w1 < w2
end

puts incs
