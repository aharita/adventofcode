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

def get_range_match(map, min, max)
  data = [min, max]
  map.each do |x|
    if min >= x[1] && min <= (x[1] + x[2] - 1)
      data[0] = x[0]
    end

    if max >= x[1] && max <= (x[1] + x[2] - 1)
      data[1] = x[1] + x[2] - 1
    end
  end

  data
end

seed_ranges = []
seeds.each_slice(2) do |min, max|
  seed_ranges << min
  seed_ranges << (min + max - 1)
end

final_range = [99999999999, 0]
seed_ranges.each_slice(2) do |min, max|
  data = [min, max]
  data = get_range_match(soil, min, max)
  data = get_range_match(fertilizer, min, max)
  data = get_range_match(water, min, max)
  data = get_range_match(light, min, max)
  data = get_range_match(temperature, min, max)
  data = get_range_match(humidity, min, max)
  data = get_range_match(location, min, max)

  final_range[0] = [final_range[0], data[0]].min
  final_range[1] = [final_range[1], data[1]].max
end

puts final_range.to_s

min_location = 999999999999999999999
(final_range[0]..final_range[1]).reverse_each do |seed|
  temp = seed
  temp = get_first_match(soil, temp)
  temp = get_first_match(fertilizer, temp)
  temp = get_first_match(water, temp)
  temp = get_first_match(light, temp)
  temp = get_first_match(temperature, temp)
  temp = get_first_match(humidity, temp)
  temp = get_first_match(location, temp)

  min_location = [min_location, temp].min
  puts "#{seed} -> #{min_location}"
  break if min_location == 0
end
