# frozen_string_literal: true

# https://adventofcode.com/2021/day/3

oxygen_gener = []
co2_scrubber = []

File.open('input.txt').each do |line|
  line = line.strip
  oxygen_gener << line
  co2_scrubber << line
end

def count_ones_zeros_at(index, report)
  data = [0, 0]

  report.each do |line|
    if line[index] == '0'
      data[1] += 1
    else
      data[0] += 1
    end
  end

  data
end

def reject_from_report_at(index, bit, report)
  report.reject { |x| x[index] == bit }
end

(0..oxygen_gener[0].length - 1).each do |index|
  oxy_count = count_ones_zeros_at(index, oxygen_gener)
  co2_count = count_ones_zeros_at(index, co2_scrubber)

  if oxygen_gener.length > 1
    oxygen_gener = reject_from_report_at(index, oxy_count[0] >= oxy_count[1] ? '0' : '1', oxygen_gener)
  end

  if co2_scrubber.length > 1
    co2_scrubber = reject_from_report_at(index, co2_count[1] <= co2_count[0] ? '1' : '0', co2_scrubber)
  end
end

puts co2_scrubber[0].to_i(2) * oxygen_gener[0].to_i(2)
