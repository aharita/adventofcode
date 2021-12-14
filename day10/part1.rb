# frozen_string_literal: true

# https://adventofcode.com/2021/day/10

table = {
  ')' => [3, '('],
  ']' => [57, '['],
  '}' => [1197, '{'],
  '>' => [25137, '<']
}
sum = 0
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
        sum += table[c][0]
        break
      end
    end
  end
end

puts sum
