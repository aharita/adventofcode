input = File.read("input.txt").lines.map do |line|
  left_part, right_part = line.split(":")
  [left_part.to_i, right_part.split.map(&:to_i)]
end

def recursion(current, numbers, target, result)
  sum = current + numbers[0]
  mul = current * numbers[0]
  con = "#{current}#{numbers[0]}".to_i

  if numbers.length == 1
    if (sum == target || mul == target || con == target)
      return true
    end

    return false
  end

  response = recursion(sum, numbers.drop(1), target, result)
  response ||= recursion(mul, numbers.drop(1), target, result)
  response ||= recursion(con, numbers.drop(1), target, result)

  return response
end

result = []

input.each do |line|
  target = line[0]
  numbers = line[1]

  response = recursion(numbers[0], numbers.drop(1), target, result)
  result << target if response
end

puts result.sum
