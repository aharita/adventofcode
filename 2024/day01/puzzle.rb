left_list, right_list = File.readlines('input.txt').map do |line|
  line.split.map(&:to_i)
end.transpose

left_list.sort!
right_list.sort!

# part1
total = left_list.zip(right_list).sum { |left, right| (left - right).abs }
puts total

# part2
right_counts = right_list.tally
total = left_list.sum { |num| right_counts[num].to_i * num }
puts total
