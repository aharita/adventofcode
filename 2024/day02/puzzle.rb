reports = File.readlines('input.txt').map do |line|
  line.split.map(&:to_i)
end

def safe_report?(report)
  i = 1
  safe = true
  increasing = report[0] < report[1]
  decreasing = report[0] > report[1]
  while (i < report.count)
    difference = (report[i - 1] - report[i]).abs
    safe = false if difference < 1 || difference > 3
    safe = false if increasing && report[i - 1] > report[i]
    safe = false if decreasing && report[i - 1] < report[i]
    i += 1
  end

  safe
end

safe_reports = 0
bad_reports = []
reports.each do |report|
  safe = safe_report?(report)
  bad_reports << report if !safe
  safe_reports += 1 if safe
end
puts safe_reports

bad_reports.each do |report|
  k = 0
  while k < report.count
    temp_report = report.dup
    temp_report.delete_at(k)
    safe = safe_report?(temp_report)
    safe_reports += 1 if safe
    break if safe
    k += 1
  end
end

puts safe_reports