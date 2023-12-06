# frozen_string_literal: true
# https://adventofcode.com/2023/day/6

data = []
File.open('input.txt').each do |line|
  data << line.strip
end

times = data[0].split(':')[1].split(' ').map(&:to_i)
distances = data[1].split(':')[1].split(' ').map(&:to_i)

puts times.to_s
puts distances.to_s

wins = Array.new(times.length, 0)
times.each_with_index do |time, index|
  # Get middle
  middle = time / 2
  
  hold = middle
  remaining = time - middle
  distance = hold * remaining
  if distance > distances[index]
    wins[index] += 1
  end
  
  # Walk left
  while true
    middle = middle - 1
    hold = middle
    remaining = time - middle
    distance = hold * remaining
    if distance > distances[index]
      wins[index] += 1
    else
      break
    end
  end

  middle = time / 2
  
  # Walk right
  while true
    middle = middle + 1
    hold = middle
    remaining = time - middle
    distance = hold * remaining
    if distance > distances[index]
      wins[index] += 1
    else
      break
    end
  end
end

puts wins.inject(:*)