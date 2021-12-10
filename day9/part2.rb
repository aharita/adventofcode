# frozen_string_literal: true

# https://adventofcode.com/2021/day/9

# data = [[10] * 102]
# File.open('input.txt').each.with_index do |line, _line_index|
#   line = line.strip.split('').map(&:to_i)
#   data << ([10].concat(line).append(10))
# end
# data << ([10] * 102)

# sum = 0
# (1..data.length - 2).each do |row_index|
#   (1..data[row_index].length - 2).each do |col_index|
#     current = data[row_index][col_index]

#     next if current >= data[row_index][col_index - 1]
#     next if current >= data[row_index][col_index + 1]
#     next if current >= data[row_index - 1][col_index]
#     next if current >= data[row_index + 1][col_index]

#     sum += current + 1
#   end
# end

# puts sum
