# frozen_string_literal: true
# https://adventofcode.com/2023/day/18

directions = []
File.open('example.txt').each_with_index do |line, index|
  directions << [line.strip.split(' ')[0], line.strip.split(' ')[1].to_i, line.strip.split(' ')[2]]
end

map = [['#']]
current_row = 0
current_col = 0

directions.each do |direction|
  case direction[0]
  when 'R'
    (current_col..(current_col + direction[1])).each do |col|
      if col >= map[0].length
        map.each do |row|
          row << nil
        end
      end

      map[current_row][col] = '#'
    end
    current_col += direction[1]
  when 'D'
    (current_row..(current_row + direction[1])).each do |row|
      if map[row].nil?
        map << Array.new(map[row - 1].length, '.')
      end

      map[row][current_col] = '#'
    end
    current_row += direction[1]
  when 'L'
    current_col.downto(current_col - direction[1]).each do |col|
      if col <= -1
        map.each do |row|
          row.insert(0, '.')
        end

        col = 0
      end

      map[current_row][col] = '#'
    end

    current_col = current_col - direction[1] < 0 ? 0 : current_col - direction[1]
  when 'U'
    current_row.downto(current_row - direction[1]).each do |row|
      if row <= -1
        map.insert(0, Array.new(map[0].length, '.'))

        row = 0
      end

      map[row][current_col] = '#'
    end

    current_row = current_row - direction[1] < 0 ? 0 : current_row - direction[1]
  end
end

def explore(map, seen, row, col, max_cols)
  return if ['#'].include? map[row][col]

  queue = [[row, col]]

  until queue.empty?
    info = queue.pop
    current_row = info[0]
    current_col = info[1]

    next if ['#'].include? map[current_row][current_col]
    next if seen[[current_row, current_col]]

    if current_row + 1 < map.length
      queue << [current_row + 1, current_col]
    end

    if current_row - 1 >= 0
      queue << [current_row - 1, current_col]
    end

    if current_col - 1 >= 0
      queue << [current_row, current_col - 1]
    end

    if current_col + 1 < max_cols
      queue << [current_row, current_col + 1]
    end

    seen[[current_row, current_col]] = true
  end
end

seen = {}

max_cols = map.map{|row| row.length }.max

# Left & Right
(0..(map.length - 1)).each do |row|
  explore(map, seen, row, 0, max_cols)
  explore(map, seen, row, max_cols - 1, max_cols)
end

# Top & Bottom
(0..(map[0].length - 1)).each do |col|
  explore(map, seen, 0, col, max_cols)
  explore(map, seen, map.length - 1, col, max_cols)
end

total_area = (map.length * max_cols)
outside = seen.keys.count

# pp "Outside Seen: #{seen.keys.count}"
# pp "Total Area: #{(map.length * max_cols)}"
pp "Total - Outside: #{total_area - outside}"
