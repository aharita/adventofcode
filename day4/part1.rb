# frozen_string_literal: true

# https://adventofcode.com/2021/day/4

boards = []
draw_numbers = nil
board = []
board_row = nil
bingo_rows = []
bingo_cols = []

File.open('input.txt').each.with_index do |line, line_index|
  line = line.strip

  if line_index.zero?
    draw_numbers = line.split(',')
    next
  end

  if line.length.zero?
    board_row = 0
    next
  end

  board_row += 1
  board << line.split(' ')

  if board_row == 5
    boards << board
    bingo_rows << [0, 0, 0, 0, 0]
    bingo_cols << [0, 0, 0, 0, 0]
    board = []
  end
end

def process(draw_numbers, boards, bingo_rows, bingo_cols)
  draw_numbers.each do |number|
    boards.each.with_index do |b, b_index|
      b.each.with_index do |row, row_index|
        row.each.with_index do |_col, col_index|
          if b[row_index][col_index] == number

            bingo_rows[b_index][row_index] += 1
            if bingo_rows[b_index][row_index] == 5
              b[row_index][col_index] = nil
              return b, number
            end

            bingo_cols[b_index][col_index] += 1
            if bingo_cols[b_index][col_index] == 5
              b[row_index][col_index] = nil
              return b, number
            end

            b[row_index][col_index] = nil
          end
        end
      end
    end
  end
end

board, number = process(draw_numbers, boards, bingo_rows, bingo_cols)
puts board.flatten.compact.map(&:to_i).sum * number.to_i
