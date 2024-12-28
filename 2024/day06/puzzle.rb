def bounds(current_y, current_x, matrix, direction)
  current_y < 0 ||
  current_y >= matrix.length ||
  current_x < 0 ||
  current_x >= matrix[0].length ||
  (current_y + direction[1] < 0) ||
  (current_y + direction[1] >= matrix.length) ||
  (current_x + direction[0] < 0) ||
  (current_x + direction[0] >= matrix[0].length)
end

def change_direction(direction)
  case direction
  when [0, -1]
    [1, 0]
  when [1, 0]
    [0, 1]
  when [0, 1]
    [-1, 0]
  when [-1, 0]
    [0, -1]
  end
end

matrix = File.readlines("input.txt").map { |line| line.chomp.chars }

start_x = 0
start_y = 0
current_x = 0
current_y = 0
matrix.each_with_index do |row, row_index|
  row.each_with_index do |col, col_index|
    if col == '^'
      current_x = col_index
      current_y = row_index
      start_x = current_x
      start_y = current_y
      break
    end
  end
end

visited = {}
visited["#{current_x},#{current_y}"] = true
direction = [0, -1]

while true
  if bounds(current_y, current_x, matrix, direction)
    break
  end

  while matrix[current_y + direction[1]][current_x + direction[0]] == '#'
    direction = change_direction(direction)
  end

  current_x += direction[0]
  current_y += direction[1]
  visited["#{current_x},#{current_y}"] = true
end
puts visited.keys.count


obstacles = 0
visited.shift
visited.keys.each do |key|
  looper = {}
  direction = [0, -1]
  current_x = start_x
  current_y = start_y
  x = key.split(',')[0].to_i
  y = key.split(',')[1].to_i

  matrix[y][x] = '#'

  while true
    if bounds(current_y, current_x, matrix, direction)
      break
    end

    while matrix[current_y + direction[1]][current_x + direction[0]] == '#'
      direction = change_direction(direction)
    end

    current_x += direction[0]
    current_y += direction[1]

    if looper["#{current_x},#{current_y},#{direction[0]},#{direction[1]}"]
      obstacles += 1
      break
    else
      looper["#{current_x},#{current_y},#{direction[0]},#{direction[1]}"] = true
    end
  end

  matrix[y][x] = '.'
end

puts obstacles