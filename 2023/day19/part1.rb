# frozen_string_literal: true
# https://adventofcode.com/2023/day/19

values = []
rules = {}
blank_line = false
File.open('example.txt').each_with_index do |line, index|
  if line.strip == ''
    blank_line = true
    next
  end

  if blank_line
    pairs = line.gsub(/[{}]/, '').split(',')
    result_hash = {}
    pairs.each do |pair|
      key, value = pair.split('=')
      result_hash[key] = value.to_i
    end

    values << result_hash
  else
    pre = line.scan(/[A-Za-z]+|<|>|\d+|[A-Za-z]+/)
    key = pre[0]
    rules[key] = []
    last = pre.pop
    pre.shift

    pre.each_slice(4) do |elements|
      rules[key] << [elements[0], elements[1], elements[2].to_i, elements[3]]
    end

    rules[key] << [last]
  end
end

def analyze_rule(rules, ratings, key)
  return key if ['A', 'R'].include?(key)

  rules[key].each do |rule|
    
    if rule.length == 1
      return analyze_rule(rules, ratings, rule[0])
    end

    if rule[1] == '<'
      if ratings[rule[0]] < rule[2]
        return analyze_rule(rules, ratings, rule[3])
      end
    else
      if ratings[rule[0]] > rule[2]
        return analyze_rule(rules, ratings, rule[3])
      end
    end
  end
end

acc = 0
until values.empty?
  ratings = values.pop

  value = analyze_rule(rules, ratings, 'in')
  if value == 'A'
    acc += ratings.values.sum
  end
end

pp acc