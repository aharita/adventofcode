# frozen_string_literal: true

# https://adventofcode.com/2021/day/8

sum = 0
File.open('input.txt').each.with_index do |line, _line_index|
  numbers = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
  data = line.split('|')[0].split(' ').map { |x| x.chars.sort.join }
  decode = line.split('|')[1].split(' ').map { |x| x.chars.sort.join }

  numbers[1] = data.find { |x| x.length == 2 }
  numbers[4] = data.find { |x| x.length == 4 }
  numbers[7] = data.find { |x| x.length == 3 }
  numbers[8] = data.find { |x| x.length == 7 }

  candidates = data.select { |x| x.length == 5 }
  number_3_index = candidates.map { |x| x.gsub(/[#{numbers[7]}]/, '') }
                             .find_index { |x| x.length == 2 }
  numbers[3] = candidates[number_3_index]

  candidates -= [numbers[3]]
  number_5_index = candidates.map { |x| x.gsub(/[#{numbers[7]}]/, '') }
                             .map { |x| x.gsub(/[#{numbers[4]}]/, '') }
                             .find_index { |x| x.length == 1 }
  numbers[5] = candidates[number_5_index]

  numbers[2] = (candidates - [numbers[5]]).first

  candidates = data.select { |x| x.length == 6 }
  number_9_index = candidates.map { |x| x.gsub(/[#{numbers[1]}]/, '') }
                             .map { |x| x.gsub(/[#{numbers[5]}]/, '') }
                             .find_index { |x| x.length == 0 }
  numbers[9] = candidates[number_9_index]

  candidates -= [numbers[9]]
  number_0_index = candidates.map { |x| x.gsub(/[#{numbers[1]}]/, '') }
                             .find_index { |x| x.length == 4 }
  numbers[0] = candidates[number_0_index]

  numbers[6] = (candidates - [numbers[0]]).first

  sum += "#{numbers.index(decode[0])}#{numbers.index(decode[1])}#{numbers.index(decode[2])}#{numbers.index(decode[3])}".to_i
end

puts sum
