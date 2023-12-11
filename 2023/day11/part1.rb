# frozen_string_literal: true
# https://adventofcode.com/2023/day/11

map = []
index = 0
File.open('example.txt').each do |line|
  row = line.strip.split('')
  map[index] = row

  if row.all?('.')
    index += 1
    map[index] = row.clone
  end

  index += 1
end

# Expand columns from right to left
col_size = map[0].length - 1
col_size.downto(0).each do |col|
  dots = []

  map.each do |row|
    dots << row[col]
  end

  next unless dots.all?('.')

  map.each do |row|
    row.insert(col + 1, '.')
  end
end

# Get galaxy positions
galaxies = []
map.each_with_index do |row, row_index|
  row.each_with_index do |col, col_index|
    galaxies << [row_index, col_index] if col == '#'
  end
end

# From left to right, for each, sum distance
total_distance = 0

(0..(galaxies.length - 1)).each do |j|
  pp "new one #{j}"
  ((j + 1)..(galaxies.length - 1)).each do |k|
    total_distance += (galaxies[j][0] - galaxies[k][0]).abs + (galaxies[j][1] - galaxies[k][1]).abs
  end
end

pp total_distance