# frozen_string_literal: true

# https://adventofcode.com/2021/day/7

data = []
minimum_fuel = 0

File.open('input.txt').each.with_index do |line, _line_index|
  data = line.split(',').map(&:to_i)
end

data.each do |d|
  fuel = 0

  data.each do |position|
    fuel += (0..(d - position).abs).sum
  end

  minimum_fuel = fuel if minimum_fuel.zero?
  minimum_fuel = [minimum_fuel, fuel].min
end

puts minimum_fuel
