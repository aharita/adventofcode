# frozen_string_literal: true
# https://adventofcode.com/2023/day/2

data = []
File.open('input.txt').each do |line|
  data << line
end

total = 0

data.each do |line|
  game_id = line.match(/Game (\d+):/)[1].to_i

  blue_max = 0
  red_max = 0
  green_max = 0

  line.split(';').each do |set|
    blue_set = set.match(/(\d+) blue/)
    red_set = set.match(/(\d+) red/)
    green_set = set.match(/(\d+) green/)

    blue_cubes = blue_set.nil? ? 0 : blue_set[1].to_i
    red_cubes = red_set.nil? ? 0 : red_set[1].to_i
    green_cubes = green_set.nil? ? 0 : green_set[1].to_i

    blue_max = [blue_max, blue_cubes].max
    green_max = [green_max, green_cubes].max
    red_max = [red_max, red_cubes].max
  end

  total += (blue_max * red_max * green_max)
end

puts total