# frozen_string_literal: true
# https://adventofcode.com/2023/day/11

map = []
index = 0
File.open('example.txt').each do |line|
  row = line.strip.split('')

  if row.all?('.')
    map[index] = row.map { 'd' }
  else
    map[index] = row
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

  next if dots.include?('#')

  map.each do |row|
    row[col] = 'd'
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
multiplier = 1000000
(0..(galaxies.length - 1)).each do |j|
  ((j + 1)..(galaxies.length - 1)).each do |k|
    # Move X first
    if galaxies[j][1] != galaxies[k][1]
      if galaxies[j][1] < galaxies[k][1]
        # Move right
        ((galaxies[j][1] + 1)..galaxies[k][1]).each do |position|
          if map[galaxies[j][0]][position] == 'd'
            total_distance += (1 * multiplier)
          else
            total_distance += 1
          end
        end
      else
        # Move left
        (galaxies[j][1] - 1).downto(galaxies[k][1]).each do |position|
          if map[galaxies[j][0]][position] == 'd'
            total_distance += (1 * multiplier)
          else
            total_distance += 1
          end
        end
      end
    end

    # Move Y later
    if galaxies[j][0] != galaxies[k][0]
      if galaxies[j][0] < galaxies[k][0]
        # Move right
        ((galaxies[j][0] + 1)..galaxies[k][0]).each do |position|
          if map[position][galaxies[j][1]] == 'd'
            total_distance += (1 * multiplier)
          else
            total_distance += 1
          end
        end
      else
        # Move left
        (galaxies[j][0] - 1).upto(galaxies[k][0]).each do |position|
          if map[position][galaxies[j][1]] == 'd'
            total_distance += (1 * multiplier)
          else
            total_distance += 1
          end
        end
      end
    end
  end
end

pp total_distance
