def bounds_check(matrix, x, y)
  x >= 0 && x < matrix.length && y >= 0 && y < matrix[0].length
end

def recursive_move(trails, matrix, previous, x, y)
  return if !bounds_check(matrix, x, y)
  return if !(previous + 1  == matrix[x][y])

  if matrix[x][y] == 9
    trails << [x, y]
    return
  end

  recursive_move(trails, matrix, matrix[x][y], x + 1, y) #right
  recursive_move(trails, matrix, matrix[x][y], x - 1, y) #left
  recursive_move(trails, matrix, matrix[x][y], x, y + 1) #down
  recursive_move(trails, matrix, matrix[x][y], x, y - 1) #up
end

matrix = File.readlines('input.txt').map { |line| line.chomp.chars.map(&:to_i) }

matrix_height = matrix.length
matrix_width = matrix[0].length

total_p1 = 0
total_p2 = 0

matrix.each_with_index do |row, x|
  row.each_with_index do |col, y|
    if col == 0
      trails = []

      recursive_move(trails, matrix, matrix[x][y], x + 1, y) #right
      recursive_move(trails, matrix, matrix[x][y], x - 1, y) #left
      recursive_move(trails, matrix, matrix[x][y], x, y + 1) #down
      recursive_move(trails, matrix, matrix[x][y], x, y - 1) #up

      total_p1 += trails.uniq.count
      total_p2 += trails.count
    end
  end
end

puts total_p1
puts total_p2