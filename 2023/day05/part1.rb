# frozen_string_literal: true
# https://adventofcode.com/2023/day/5

seeds = []
soil = []
fertilizer = []
water = []
light = []
temperature = []
humidity = []
location = []

index = 1
File.open('input.txt').each do |line|
  line = line.strip
  if line == ''
    index += 1
    next
  end

  next if line.include?('map')

  case index
  when 1
    seeds = line.split(':')[1].split(' ').map(&:to_i)
  when 2
    soil << line.split(' ').map(&:to_i)
  when 3
    fertilizer << line.split(' ').map(&:to_i)
  when 4
    water << line.split(' ').map(&:to_i)
  when 5
    light << line.split(' ').map(&:to_i)
  when 6
    temperature << line.split(' ').map(&:to_i)
  when 7
    humidity << line.split(' ').map(&:to_i)
  when 8
    location << line.split(' ').map(&:to_i)
  end
end

def get_first_match(map, temp)
  map.each do |x|
    if temp >= x[1] && temp <= (x[1] + x[2] - 1)
      return temp - x[1] + x[0]
    end
  end

  temp
end

min_location = 999999999999999999999
seeds.each do |seed|
  temp = seed
  temp = get_first_match(soil, temp)
  temp = get_first_match(fertilizer, temp)
  temp = get_first_match(water, temp)
  temp = get_first_match(light, temp)
  temp = get_first_match(temperature, temp)
  temp = get_first_match(humidity, temp)
  temp = get_first_match(location, temp)

  min_location = [min_location, temp].min
end

puts min_location