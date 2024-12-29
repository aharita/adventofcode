positions = Hash.new { |hash, key| hash[key] = [] }

matrix = File.readlines("input.txt", chomp: true).map.with_index do |row, y|
  row.chars.each_with_index do |char, x|
    next if char == '.'

    positions[char] << [x, y]
  end

  row
end

matrix_width = matrix[0].length
matrix_height = matrix.length
new_elements = Set.new

positions.each do |char, coords|
  coords.each_with_index do |coord1, i|
    (i + 1...coords.length).each do |j|
      coord2 = coords[j]
      distance_x = (coord1[0] - coord2[0]).abs
      distance_y = (coord1[1] - coord2[1]).abs

      left_point, right_point = if coord1[0] < coord2[0]
        [coord1, coord2]
      else
        [coord2, coord1]
      end

      temp_left_point = left_point.dup
      temp_right_point = right_point.dup

      new_elements.add([coord1[0], coord1[1]])
      new_elements.add([coord2[0], coord2[1]])

      # left points
      while true
        new_left_x = temp_left_point[0] - distance_x
        if temp_left_point[1] < right_point[1]
          new_left_y = temp_left_point[1] - distance_y
        else
          new_left_y = temp_left_point[1] + distance_y
        end

        if new_left_x >= 0 && new_left_x < matrix_width && new_left_y >= 0 && new_left_y < matrix_height
          new_elements.add([new_left_x, new_left_y])
        else
          break
        end

        temp_left_point = [new_left_x, new_left_y]
      end

      # right points
      while true
        new_right_x = temp_right_point[0] + distance_x
        if left_point[1] < temp_right_point[1]
          new_right_y = temp_right_point[1] + distance_y
        else
          new_right_y = temp_right_point[1] - distance_y
        end

        if new_right_x >= 0 && new_right_x < matrix_width && new_right_y >= 0 && new_right_y < matrix_height
          new_elements.add([new_right_x, new_right_y])
        else
          break
        end

        temp_right_point = [new_right_x, new_right_y]
      end
    end
  end
end

puts "#{new_elements.count}"
