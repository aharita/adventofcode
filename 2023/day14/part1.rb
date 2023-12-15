# frozen_string_literal: true
# https://adventofcode.com/2023/day/14

platform = []
File.open('example.txt').each_with_index do |line, index|
  platform << line.strip
end

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

acc = 0
platform.length.downto(1).each_with_index do |number, index|
  acc += (platform[index].count('O')) * number
end

pp acc
