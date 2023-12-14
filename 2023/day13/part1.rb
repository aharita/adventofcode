# frozen_string_literal: true
# https://adventofcode.com/2023/day/13

index = 0
lines = {}
File.open('example.txt').each do |line|
  if line.strip == ''
    index += 1
    next
  end

  lines[index] ||= []
  lines[index] << line.strip
end

acc = 0
lines.each do |k, v|

  # Find Vertical Middle
  verticals = []
  row = 0
  li = 0
  ri = 1
  while ri < v[0].length
    if v[row][li] == v[row][ri]
      row += 1
    else
      row = 0
      li += 1
      ri += 1
    end

    if row == v.count
      verticals << [li, ri]
      row = 0
      li += 1
      ri += 1
    end
  end

  # pp verticals

  # Check if vertical is mirror
  vertical_mirror = false
  vertical_counter = 0
  verticals.each do |matching|
    row = 0

    li = matching[0]
    ri = matching[1]
    while ri < v[row].length && li >= 0
      break if li < 0

      # pp "#{li} #{ri}"

      if v[row][li] == v[row][ri]
        row += 1
        vertical_mirror = true
      else
        vertical_mirror = false
        break
      end

      if row == v.count
        li -= 1
        ri += 1
        row = 0
      end
    end

    if vertical_mirror
      vertical_counter = matching[0] + 1
      break
    end
  end



  if vertical_mirror
    acc += vertical_counter
    # pp 'vertical'
    next
  end

  # pp 'horizontal'

  # Find Horizontal Middle
  horizontals = []
  row1 = 0
  row2 = 1
  while row2 < v.length
    if v[row1] == v[row2]
      horizontals << [row1, row2]
    end

    row1 += 1
    row2 += 1
  end

  # if horizontals.count > 1
  #   pp v
  #   pp horizontals
  # end

  horizontal_times = 0
  horizontals.each do |matching|
    row1 = matching[0]
    row2 = matching[1]
    horizontal_mirror = true
    while row1 >= 0 && row2 < v.length

      if v[row1] == v[row2]

      else
        horizontal_mirror = false
        break
      end

      row1 -= 1
      row2 += 1
    end

    if horizontal_mirror
      horizontal_times = (matching[0] + 1) * 100
      break
    end

  end

  acc += horizontal_times

end

pp acc
