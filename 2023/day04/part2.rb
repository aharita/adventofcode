# frozen_string_literal: true
# https://adventofcode.com/2023/day/4

data = []
copies = {}
File.open('input.txt').each.with_index do |line, index|
  numbers = line.split(':').map(&:strip)
  data << numbers[1].split('|').map(&:strip)
  copies[index] = 1
end

data.each.with_index do |game, index|
  left = {}

  game[0].split(' ').map(&:to_i).each do |number|
    left[number] = true
  end

  winner_index = 1
  game[1].split(' ').map(&:to_i).each do |number|
    if left[number]
      copies[index + winner_index] += (1 * copies[index])
      winner_index += 1
    end
  end

end

puts copies.values.sum
