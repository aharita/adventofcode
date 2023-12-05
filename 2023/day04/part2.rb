# frozen_string_literal: true
# https://adventofcode.com/2023/day/4

data = []
File.open('input.txt').each do |line|
  numbers = line.split(':').map(&:strip)
  data << numbers[1].split('|').map(&:strip)
end

total = 0
data.each do |game|
  left = {}
  game_total = 0

  game[0].split(' ').map(&:to_i).each do |number|
    left[number] = true
  end

  game[1].split(' ').map(&:to_i).each do |number|
    if left[number]
      if game_total == 0
        game_total = 1
      else
        game_total *= 2
      end
    end
  end

  total += game_total
end

puts total