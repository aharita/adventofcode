lines = IO.readlines("input.txt").map(&:chomp)
matrix = lines.map { |row| row.chars }

def bounds(x, y, matrix)
  x >= 0 && y >= 0 && x < matrix.length && y < matrix[0].length
end

def search(matrix, x, y, x_vel, y_vel)
  while bounds(x, y, matrix)
    x = x + x_vel
    y = y + y_vel

    if bounds(x, y, matrix) && matrix[x][y] == 'M'
      x = x + x_vel
      y = y + y_vel

      if bounds(x, y, matrix) && matrix[x][y] == 'A'
        x = x + x_vel
        y = y + y_vel

        if bounds(x, y, matrix) && matrix[x][y] == 'S'
          return 1
        else
          return 0
        end
      else
        return 0
      end
    else
      return 0
    end
  end

  return 0
end

total = 0
matrix.each_with_index do |row, row_i|
  row.each_with_index do |_col, col_i|
    if matrix[row_i][col_i] == 'X'
      # left
      total += search(matrix, row_i, col_i, -1, 0)
      # right
      total += search(matrix, row_i, col_i, 1, 0)
      # down
      total += search(matrix, row_i, col_i, 0, 1)
      # up
      total += search(matrix, row_i, col_i, 0, -1)
      # upleft
      total += search(matrix, row_i, col_i, -1, -1)
      # upright
      total += search(matrix, row_i, col_i, 1, -1)
      # downleft
      total += search(matrix, row_i, col_i, -1, 1)
      # downright
      total += search(matrix, row_i, col_i, 1, 1)
    end
  end
end
puts total


total = 0
matrix.each_with_index do |row, row_i|
  row.each_with_index do |_col, col_i|
    if matrix[row_i][col_i] == 'A'

      tester = []
      if bounds(row_i - 1, col_i - 1, matrix)
        # upleft
        tester << matrix[row_i-1][col_i-1]

        if bounds(row_i + 1, col_i + 1, matrix)
          # downright
          tester << matrix[row_i+1][col_i+1]
        else
          next
        end

        if tester.include?('M') && tester.include?('S')
          tester = []
          # upright
          if bounds(row_i + 1, col_i - 1, matrix)
            tester << matrix[row_i + 1][col_i - 1]

            if bounds(row_i - 1, col_i + 1, matrix)
              # downleft
              tester << matrix[row_i - 1][col_i + 1]
            else
              next
            end

            if tester.include?('M') && tester.include?('S')
              total += 1
            end

          else
            next
          end

        else
          next
        end

      else
        next
      end

    end
  end
end
puts total