# frozen_string_literal: true

# https://adventofcode.com/2021/day/5

data = []
coords = Hash.new(0)
count = 0

File.open('input.txt').each.with_index do |line, _line_index|
  line = line.sub(' -> ', ',').split(',')
  data << [line[0].to_i, line[1].to_i, line[2].to_i, line[3].to_i]
end

data.each.with_index do |point, _index|
  x1 = point[0]
  y1 = point[1]
  x2 = point[2]
  y2 = point[3]

  if x1 == x2
    if y1 < y2
      (y1..y2).each do |y|
        coords["#{x1},#{y}"] += 1
      end
    else
      (y2..y1).each do |y|
        coords["#{x1},#{y}"] += 1
      end
    end
  elsif y1 == y2
    if x1 < x2
      (x1..x2).each do |x|
        coords["#{x},#{y1}"] += 1
      end
    else
      (x2..x1).each do |x|
        coords["#{x},#{y1}"] += 1
      end
    end
  end
end

coords.each do |_k, v|
  count += 1 if v >= 2
end

puts count
