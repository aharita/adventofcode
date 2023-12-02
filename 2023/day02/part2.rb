# # frozen_string_literal: true
# # https://adventofcode.com/2023/day/2

# data = []
# File.open('input.txt').each do |line|
#   data << line
# end

# map = ["zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine"]
# sum = 0
# data.each do |line|
#   numbers = {}
#   map.each do |number|
#     index = line.index(number)
#     if !index.nil?
#       line.gsub(number).map { Regexp.last_match.begin(0) }.each do |instances|
#         numbers[instances] = map.find_index(number)
#       end
#     end
#   end

#   line.each_char.with_index do |char, index|
#     if char.match(/^(\d)+$/)
#       numbers[index] = char.to_i
#     end
#   end

#   sum = sum + "#{numbers[numbers.keys.sort.first]}#{numbers[numbers.keys.sort.last]}".to_i
# end

# puts sum