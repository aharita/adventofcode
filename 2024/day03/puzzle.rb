memory_lines = IO.readlines("input.txt")

total = 0
enabled = true

memory_lines.each do |line|
  i = 0
  while i < line.length
    if line[i, 4] == 'do()'
      enabled = true
      i = i + 4
    end

    if line[i, 7] == "don't()"
      enabled = false
      i = i + 7
    end

    # find mul(
    if line[i, 4] == 'mul('
      left_number = []
      right_number = []

      i = i + 4

      # find the first number
      while true
        if line[i] >= '0' && line[i] <= '9'
          left_number << line[i]
        else
          break
        end
        i += 1
      end

      # verify its a comma
      if line[i] == ','
        i += 1
      else
      end

      # find second number
      while true
        if line[i] >= '0' && line[i] <= '9'
          right_number << line[i]
        else
          break
        end
        i += 1
      end

      # find end
      if line[i] == ')'
        if left_number.count >= 1 && left_number.count <= 3 && right_number.count >=1 && right_number.count <= 3 && enabled
          total += (left_number.join.to_i * right_number.join.to_i)
        end
      else
        left_number = []
        right_number = []
      end
    end

    i += 1
  end
end

puts total