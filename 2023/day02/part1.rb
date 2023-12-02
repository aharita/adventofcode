# frozen_string_literal: true
# https://adventofcode.com/2023/day/2

data = []
File.open('input.txt').each do |line|
  data << line
end

red = 12
green = 13
blue = 14
game_id_count = 0

data.each do |line|
  impossible_game = false
  game_id = line.match(/Game (\d+):/)[1].to_i

  line.split(';').each do |set|
    blue_set = set.match(/(\d+) blue/)
    red_set = set.match(/(\d+) red/)
    green_set = set.match(/(\d+) green/)

    blue_cubes = blue_set.nil? ? 0 : blue_set[1].to_i
    red_cubes = red_set.nil? ? 0 : red_set[1].to_i
    green_cubes = green_set.nil? ? 0 : green_set[1].to_i

    if blue_cubes > blue || red_cubes > red || green_cubes > green
      impossible_game = true
    end

  end

  game_id_count += game_id if !impossible_game
end

puts game_id_count