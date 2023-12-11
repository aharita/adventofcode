# frozen_string_literal: true
# https://adventofcode.com/2023/day/10

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
# I chose to start with south because of my input
direction = 's'
while true
  row = current_position[0]
  col = current_position[1]
  symbol = map[row][col]

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

pp times / 2
