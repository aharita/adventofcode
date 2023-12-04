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
      return true if data[row - 1][col + index] != '.' && data[row - 1][col + index] !~ /\d/
    end
  end

  # Check Bottom
  if row + 1 <= data.length - 1
    (0..number_length - 1).each do |index|
      return true if data[row + 1][col + index] != '.' && data[row + 1][col + index] !~ /\d/
    end
  end

  # Check Left
  if col - 1 >= 0
    if row - 1 >= 0
      return true if data[row - 1][col - 1] != '.' && data[row - 1][col - 1] !~ /\d/
    end

    if row + 1 <= data.length - 1
      return true if data[row + 1][col - 1] != '.' && data[row + 1][col - 1] !~ /\d/
    end

    return true if data[row][col - 1] != '.' && data[row][col - 1] !~ /\d/
  end

  # Check Right
  if col + number_length <= data[0].length - 1
    if row - 1 >= 0
      return true if data[row - 1][col + number_length] != '.' && data[row - 1][col + number_length] !~ /\d/
    end

    if row + 1 <= data.length - 1
      return true if data[row + 1][col + number_length] != '.' && data[row + 1][col + number_length] !~ /\d/
    end

    return true if data[row][col + number_length] != '.' && data[row][col + number_length] !~ /\d/
  end
end

sum = 0
data.each.with_index do |line, row|
  temp_number = ""
  line.each.with_index do |char, col|
    if char =~ /\d/
      temp_number += char
    else
      if temp_number.length > 0
        if adjacent_symbol?(data, temp_number.length, row, col - temp_number.length)
          sum += temp_number.to_i
        end

        temp_number = ""
      end
    end

    if line.length == col + 1 && temp_number.length > 0
      if adjacent_symbol?(data, temp_number.length, row, col - (temp_number.length - 1))
        sum += temp_number.to_i
      end

      temp_number = ""
    end
  end
end

puts sum