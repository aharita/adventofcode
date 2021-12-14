# frozen_string_literal: true

# https://adventofcode.com/2021/day/10

table = { ')' => [1, '('], ']' => [2, '['], '}' => [3, '{'], '>' => [4, '<'] }
table2 = { '(' => 1, '[' => 2, '{' => 3, '<' => 4 }
sums = []
File.open('input.txt').each.with_index do |line, _line_index|
  queue = []
  line.strip.split('').each do |c|
    case c
    when '(', '[', '{', '<'
      queue << c
    else
      if table[c][1] == queue.last
        queue.pop
      else
        queue = []
        break
      end
    end
  end

  next if queue.empty?

  sum = 0
  queue.reverse.each do |c|
    sum = (sum * 5) + table2[c]
  end
  sums << sum
end

puts sums.sort[sums.length / 2]
