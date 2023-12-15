# frozen_string_literal: true
# https://adventofcode.com/2023/day/14

platform = []
File.open('example.txt').each_with_index do |line, index|
  platform << line.strip.split('')
end

def tilt(platform)
  (0..platform[0].length - 1).each do |col_index|
    row_index = 0
    while row_index < platform.length

      current_char = platform[row_index][col_index]

      if current_char == '#' || current_char == '.'
        row_index += 1
        next
      end

      if row_index == 0
        row_index += 1
        next
      end

      previous_char = platform[row_index - 1][col_index]
      if previous_char == '.'
        platform[row_index - 1][col_index] = 'O'
        platform[row_index][col_index] = '.'
        row_index -= 1
        next
      end

      row_index += 1
    end
  end
end

north = platform
times = 0

while times < 200
  tilt(north)
  west = north.transpose.map(&:reverse)

  tilt(west)
  south = west.transpose.map(&:reverse)

  tilt(south)
  east = south.transpose.map(&:reverse)

  tilt(east)
  north = east.transpose.map(&:reverse)

  times += 1

  acc = 0
  north.length.downto(1).each_with_index do |number, index|
    acc += (north[index].count('O')) * number
  end
  pp acc

end

# Pattern is this, but I counted until I got to the pattern (115 entries),
# and then (1000000000 - 115) % 34   34 because thats how many are in the pattern

# Maybe luck, yet to do it programatically

# 85157
# 85192
# 85224
# 85245
# 85260
# 85270
# 85261
# 85247
# 85223
# 85206
# 85175
# 85155
# 85125
# 85115
# 85111
# 85120
# 85130
# 85160
# 85189
# 85227
# 85242
# 85263
# 85267
# 85264
# 85244
# 85226
# 85203
# 85178
# 85152
# 85128
# 85112
# 85114
# 85117
# 85133