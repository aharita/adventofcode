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
  winner_count = boards.count
  board_winners = []

  draw_numbers.each do |number|
    boards.each.with_index do |b, b_index|
      bingo = process_board(b, b_index, number, bingo_rows, bingo_cols)

      next if board_winners.include?(b_index)

      if bingo && winner_count == 1
        return b, number
      end

      if bingo
        board_winners << b_index
        winner_count -= 1
        next
      end
    end
  end
end

def process_board(b, b_index, number, bingo_rows, bingo_cols)
  b.each.with_index do |row, row_index|
    row.each.with_index do |_col, col_index|
      if b[row_index][col_index] == number

        bingo_rows[b_index][row_index] += 1
        if bingo_rows[b_index][row_index] == 5
          b[row_index][col_index] = nil
          return true
        end

        bingo_cols[b_index][col_index] += 1
        if bingo_cols[b_index][col_index] == 5
          b[row_index][col_index] = nil
          return true
        end

        b[row_index][col_index] = nil
      end
    end
  end

  false
end

board, number = process(draw_numbers, boards, bingo_rows, bingo_cols)
puts board.flatten.compact.map(&:to_i).sum * number.to_i
