# frozen_string_literal: true
# https://adventofcode.com/2023/day/16

data = []
File.open('example.txt').each_with_index do |line, index|
  data << line.strip.split('')
end

def move(info, queue, data)
  direction = info[0]
  row = info[1]
  col = info[2]

  case direction
  when 'r'
    col += 1
  when 'l'
    col -= 1
  when 'u'
    row -= 1
  when 'd'
    row += 1
  end

  if col < 0 || col >= data[0].length || row < 0 || row >= data.length
    # Invalid Row or Col
    return
  end
  
  tile = data[row][col]

  case tile
  when '.'
    queue << [direction, row, col]
  when '|'
    if direction == 'r' || direction == 'l'
      queue << ['u', row, col]
      queue << ['d', row, col]
    else
      queue << [direction, row, col]
    end
  when '-'
    if direction == 'u' || direction == 'd'
      queue << ['l', row, col]
      queue << ['r', row, col]
    else
      queue << [direction, row, col]
    end
  when '\\'
    case direction
    when 'r'
      queue << ['d', row, col]
    when 'l'
      queue << ['u', row, col]
    when 'd'
      queue << ['r', row, col]
    when 'u'
      queue << ['l', row, col]
    end
  when '/'
    case direction
    when 'r'
      queue << ['u', row, col]
    when 'l'
      queue << ['d', row, col]
    when 'd'
      queue << ['l', row, col]
    when 'u'
      queue << ['r', row, col]
    end
  end
end

def run(direction, position, data)
  energized = { }
  queue = [ [direction, position[0], position[1]] ]
  seen = { }
  
  until queue.empty?
    info = queue.pop
  
    if seen[info]
      next
    else
      seen[info] = true
      energized[ [ info[1], info[2] ] ] = true
      move(info, queue, data)
    end
  
  end
  
  energized.keys.count - 1
end

energized_max = 0

# Left Side (Left to Right)
(0..data.length - 1).each do |row|
  direction = 'r'
  position = [row, -1]
  energized_max = [run(direction, position, data), energized_max].max
end

# Right Side (Right to Left)
(0..data.length - 1).each do |row|
  direction = 'l'
  position = [row, data[0].length]
  energized_max = [run(direction, position, data), energized_max].max
end

# Top side (Up to Down)
(0..data[0].length - 1).each do |col|
  direction = 'd'
  position = [-1, col]
  energized_max = [run(direction, position, data), energized_max].max
end

# Bottom side (Down to Up)
(0..data[0].length - 1).each do |col|
  direction = 'u'
  position = [data.length, col]
  energized_max = [run(direction, position, data), energized_max].max
end

pp energized_max