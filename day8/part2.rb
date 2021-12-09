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

  # Determine number 3, grab all with length 5
  candidates_for_3 = data.select { |x| x.length == 5 }
  number_3_index   = candidates_for_3.map { |x| x.gsub(/[#{numbers[7]}]/, '') }
                                     .find_index { |x| x.length == 2 }
  numbers[3] = candidates_for_3[number_3_index]

  # Determine number 5
  candidates_for_5 = candidates_for_3 - [numbers[3]]
  number_5_index   = candidates_for_5.map { |x| x.gsub(/[#{numbers[7]}]/, '') }
                                     .map { |x| x.gsub(/[#{numbers[4]}]/, '') }
                                     .find_index { |x| x.length == 1 }

  numbers[5] = candidates_for_5[number_5_index]

  # Number 2 is what is left
  numbers[2] = (candidates_for_5 - [numbers[5]]).first

  # Determine number 9, grab all with length 6
  candidates_for_9 = data.select { |x| x.length == 6 }
  number_9_index   = candidates_for_9.map { |x| x.gsub(/[#{numbers[1]}]/, '') }
                                     .map { |x| x.gsub(/[#{numbers[5]}]/, '') }
                                     .find_index { |x| x.length == 0 }
  numbers[9] = candidates_for_9[number_9_index]

  # Determine number 0
  candidates_for_0 = candidates_for_9 - [numbers[9]]
  number_0_index   = candidates_for_0.map { |x| x.gsub(/[#{numbers[1]}]/, '') }
                                     .find_index { |x| x.length == 4 }

  numbers[0] = candidates_for_0[number_0_index]

  # Number 6 is what is left
  numbers[6] = (candidates_for_0 - [numbers[0]]).first

  sum += "#{numbers.index(decode[0])}#{numbers.index(decode[1])}#{numbers.index(decode[2])}#{numbers.index(decode[3])}".to_i
end

puts sum

# 1 = 2 segs

# 7 = 3 segs

# 4 = 4 segs

# 2 = 5 segs
# 3 = 5 segs
# 5 = 5 segs

# 0 = 6 segs
# 9 = 6 segs
# 6 = 6 segs

# 8 = 7 segs

# NUMBER 8 == length 7
# NUMBER 1 == length 2
# NUMBER 7 == length 3
# NUMBER 4 == length 4
# NUMBER 3 == whichever is left with 2 letters when you remove number 7 on each lengths of 5
# NUMBER 5 == number 7 - number 4 but make sure its not number 3
# NUMBER 2 == length 5 that is not number 3 and number 5
# NUMBER 9 == for all lengths 6, - number 5 - number 1, length remaining would be 0
# NUMBER 0 == do not use 9, - number 1, whichever is left with 4
# NUMBER 6 == last one
