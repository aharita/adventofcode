# frozen_string_literal: true
# https://adventofcode.com/2023/day/1

data = []
File.open('input.txt').each do |line|
  data << line
end

sum = 0
data.each do |line|
  first = nil
  current = nil

  line.each_char do |c|
    if c.match(/^(\d)+$/)
      current = c
      first = current if first.nil?
    end
  end

  sum = sum + "#{first}#{current}".to_i
end

puts sum