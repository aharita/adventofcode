# frozen_string_literal: true

# https://adventofcode.com/2021/day/8

data = []

File.open('input.txt').each.with_index do |line, _line_index|
  data << line.split('|')[1].split(' ').select { |x| [2, 3, 4, 7].include?(x.length) }
end

puts data.flatten.length
