# frozen_string_literal: true

# https://adventofcode.com/2021/day/6

data = []
new_born = []

File.open('input.txt').each.with_index do |line, _line_index|
  data = line.split(',').map(&:to_i)
end

(0..79).each do |_day|
  data.each.with_index do |_fish, index|
    if (data[index]).zero?
      new_born << 8
      data[index] = 6
    else
      data[index] -= 1
    end
  end

  data.concat(new_born)
  new_born = []
end

puts data.length
