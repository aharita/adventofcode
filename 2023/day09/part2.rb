# frozen_string_literal: true
# https://adventofcode.com/2023/day/9

report = {}
File.open('input.txt').each_with_index do |line, index|
  report[index] = []
  report[index] << line.strip.split(' ').map(&:to_i)
end

sums = 0
report.each_with_index do |(k, v), index|
  main_history = v
  current_history = v[0]

  # Then the while loop until all numbers from the difference is the same
  while true
    difference = []
    (0..(current_history.length - 2)).each do |i|
      difference << (current_history[i + 1] - current_history[i])
    end

    main_history << difference
    break if difference.all?(0)
    current_history = difference
  end

  # Once the sequences are found, bubble sum up
  prediction_right = 0
  prediction_left = 0
  (main_history.length - 1).downto(0) do |row|
    prediction_left = main_history[row].first - prediction_left
    prediction_right += main_history[row].last
  end

  #sums += prediction_right
  sums += prediction_left
end

puts report.to_s
puts sums