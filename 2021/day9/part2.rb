# frozen_string_literal: true

# https://adventofcode.com/2021/day/9

seen = {}
sizes = []
data = [[9] * 102]
File.open('input.txt').each.with_index do |line, _line_index|
  line = line.strip.split('').map(&:to_i)
  data << ([9].concat(line).append(9))
end
data << ([9] * 102)

def check_point(x, y, data, seen)
  key = "#{x},#{y}"
  return 0 if seen[key] == true

  seen[key] = true
  return 0 if x > 101 || y > 101 || data[x][y] == 9

  sum = 0
  sum += check_point(x + 1, y, data, seen)
  sum += check_point(x - 1, y, data, seen)
  sum += check_point(x, y + 1, data, seen)
  sum += check_point(x, y - 1, data, seen)

  sum + 1
end

(1..data.length - 2).each do |row_index|
  (1..data[row_index].length - 2).each do |col_index|
    sizes << check_point(row_index, col_index, data, seen)
  end
end

puts sizes.sort.last(3).inject(&:*)
