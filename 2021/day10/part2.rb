# frozen_string_literal: true

# https://adventofcode.com/2021/day/10

mapping = { ')' => '(', ']' => '[', '}' => '{', '>' => '<' }
scores_table = { '(' => 1, '[' => 2, '{' => 3, '<' => 4 }
sums = []
File.open('input.txt').each.with_index do |line, _line_index|
  stack = []
  line.strip.split('').each do |char|
    case char
    when '(', '[', '{', '<'
      stack << char
    else
      if mapping[char] == stack.last
        stack.pop
      else
        stack = []
        break
      end
    end
  end

  next if stack.empty?

  sum = 0
  stack.reverse.each do |char|
    sum = (sum * 5) + scores_table[char]
  end
  sums << sum
end

puts sums.sort[sums.length / 2]
