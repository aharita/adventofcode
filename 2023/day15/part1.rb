# frozen_string_literal: true
# https://adventofcode.com/2023/day/15

data = []
File.open('example.txt').each_with_index do |line, index|
  data << line.strip.split(',')
end

def get_it(char, previous)
  (previous + char.ord) * 17 % 256
end

acc = 0
data.flatten.each do |part|
  x = 0
  part.each_char do |char|
    x = get_it(char, x)
  end
  acc += x
end

pp acc