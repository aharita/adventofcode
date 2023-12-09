# frozen_string_literal: true
# https://adventofcode.com/2023/day/8

pattern = nil
mapping = {}
starting_nodes = []
ending_nodes = []
File.open('input.txt').each_with_index do |line, index|
  pattern = line.strip if index.zero?
  next if index <= 1

  node_value = line.split('=')[0].strip
  left_value = line.split('=')[1].strip[1..-1].split(',')[0].strip
  right_value = line.split('=')[1].strip[1..-2].split(',')[1].strip

  mapping[node_value] = [left_value, right_value]

  if node_value[2] == 'A'
    starting_nodes << node_value
  end

  if node_value[2] == 'Z'
    ending_nodes << node_value
  end
end

puts starting_nodes.to_s

def steps_for_node(node, pattern, mapping)
  steps = 0
  next_node = node

  while true
    pattern.each_char do |char|
      direction = 0 if char == 'L'
      direction = 1 if char == 'R'
      steps += 1
      
      next_node = mapping[next_node][direction]

      if next_node[2] == 'Z'
        return steps
      end
    end
  end
end

node_steps = []

starting_nodes.each do |node|
  node_steps << steps_for_node(node, pattern, mapping)
end

puts node_steps.reduce(:lcm)
