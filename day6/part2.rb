# frozen_string_literal: true

# https://adventofcode.com/2021/day/6

data = [0] * 10

File.open('input.txt').each.with_index do |line, _line_index|
  fishes = line.split(',').map(&:to_i)
  fishes.each do |fish|
    data[fish] += 1
  end
end

spawns = data.sum

(0..255).each do |_day|
  if data[0].positive?
    data[9] += data[0]
    data[7] += data[0]
    spawns += data[0]
    data[0] = 0
  end

  data.each_index do |index|
    next if data[index].zero?

    data[index - 1] = data[index]
    data[index] = 0
  end
end

puts spawns
