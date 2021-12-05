# frozen_string_literal: true

# https://adventofcode.com/2021/day/3

data = []
initialized = false
gamma = ''
epsilon = ''

File.open('input.txt').each do |line|
  line = line.strip

  if initialized == false
    (1..line.length).each { data << [0, 0] }
    initialized = true
  end

  (0..data.length - 1).each do |index|
    if line[index] == '0'
      data[index][0] += 1
    else
      data[index][1] += 1
    end
  end
end

(0..data.length - 1).each do |index|
  if data[index][0] < data[index][1]
    gamma += '1'
    epsilon += '0'
  else
    gamma += '0'
    epsilon += '1'
  end
end

puts gamma.to_i(2) * epsilon.to_i(2)
