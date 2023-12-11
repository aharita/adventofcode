# frozen_string_literal: true
# https://adventofcode.com/2023/day/10

visited = {}
map = []
start = [0, 0]
File.open('example.txt').each_with_index do |line, index|
  map[index] = line.strip.split('')

  if map[index].include?('S')
    start = [index, map[index].index('S')]
  end
end

def from_to(tile, direction)
  if direction == 'e'
    if tile == '-'
      return 'e'
    end

    if tile == 'J'
      return 'n'
    end

    if tile == '7'
      return 's'
    end
  end

  if direction == 'w'
    if tile == 'L'
      return 'n'
    end

    if tile == '-'
      return 'w'
    end

    if tile == 'F'
      return 's'
    end
  end

  if direction == 'n'
    if tile == '|'
      return 'n'
    end

    if tile == 'F'
      return 'e'
    end

    if tile == '7'
      return 'w'
    end
  end

  if direction == 's'
    if tile == '|'
      return 's'
    end

    if tile == 'J'
      return 'w'
    end

    if tile == 'L'
      return 'e'
    end
  end
end

def update_current_position(direction, current_position)
  if direction == 'n'
    return [current_position[0] - 1, current_position[1]]
  end

  if direction == 's'
    return [current_position[0] + 1, current_position[1]]
  end

  if direction == 'e'
    return [current_position[0], current_position[1] + 1]
  end

  if direction == 'w'
    return [current_position[0], current_position[1] - 1]
  end
end

times = 0
current_position = start
direction = 's'
while true
  row = current_position[0]
  col = current_position[1]
  symbol = map[row][col]

  visited[current_position] = true

  break if times > 1 && symbol == 'S'
  times += 1

  # Move to this direction first
  current_position = update_current_position(direction, current_position)

  # Get new symbol
  row = current_position[0]
  col = current_position[1]
  symbol = map[row][col]

  # Update new direction
  direction = from_to(symbol, direction)
end

# The following algorithm is called Ray Casting
# In a polygon, when you draw a line to the left from any point (inside or outside) and if it crosses odd
# number of times then it's a point that is inside. Because this is a squared poligon, we chose only J, L, | and S characters
# that count as a "wall". Any other characeters we skip/ignore like -, F, 7
# In my input, S behaves like a |, so thats why I count it. It depends on your input
total_crossings = 0
map.each_with_index do |row, row_index|
  row.each_with_index do |col, col_index|

    next if visited[ [row_index, col_index] ]

    steps = -1
    crossings = 0
    while (col_index + steps) >= 0
      if visited[ [row_index, col_index + steps] ] && ['J', 'L', '|', 'S'].include?(map[row_index][col_index + steps])
        crossings += 1
      end
      steps -= 1
    end

    if crossings.odd?
      total_crossings += 1
    end

  end
end

pp total_crossings
