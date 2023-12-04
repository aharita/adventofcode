# frozen_string_literal: true
# https://adventofcode.com/2023/day/3

data = []
File.open('input.txt').each do |line|
  to_add = line.split('')
  to_add.pop()
  data << to_add
end

def adjacent_symbol?(data, number_length, row, col)
  # Check Top
  if row - 1 >= 0
    (0..number_length - 1).each do |index|
      return [row - 1, col + index] if data[row - 1][col + index] == '*'
    end
  end

  # Check Bottom
  if row + 1 <= data.length - 1
    (0..number_length - 1).each do |index|
      return [row + 1, col + index] if data[row + 1][col + index] == '*'
    end
  end

  # Check Left
  if col - 1 >= 0
    if row - 1 >= 0
      return [row - 1, col - 1] if data[row - 1][col - 1] == '*'
    end

    if row + 1 <= data.length - 1
      return [row + 1, col - 1] if data[row + 1][col - 1] == '*'
    end

    return [row, col - 1] if data[row][col - 1] == '*'
  end

  # Check Right
  if col + number_length <= data[0].length - 1
    if row - 1 >= 0
      return [row - 1, col + number_length] if data[row - 1][col + number_length] == '*'
    end

    if row + 1 <= data.length - 1
      return [row + 1, col + number_length] if data[row + 1][col + number_length] == '*'
    end

    return [row, col + number_length] if data[row][col + number_length] == '*'
  end
end

numbers = {}
data.each.with_index do |line, row|
  temp_number = ""
  line.each.with_index do |char, col|
    if char =~ /\d/
      temp_number += char
    else
      if temp_number.length > 0
        coords = adjacent_symbol?(data, temp_number.length, row, col - temp_number.length)
        if coords
          numbers[coords] ||= []
          numbers[coords] << temp_number.to_i
        end

        temp_number = ""
      end
    end

    if line.length == col + 1 && temp_number.length > 0
      coords = adjacent_symbol?(data, temp_number.length, row, col - temp_number.length)
      if coords
        numbers[coords] ||= []
        numbers[coords] << temp_number.to_i
      end

      temp_number = ""
    end
  end
end

sum = 0
numbers.each do |key, values|
  if values.length == 2
    puts values.to_s
    sum += values[0] * values[1]
  end
end

puts sum