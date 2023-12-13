# frozen_string_literal: true
# https://adventofcode.com/2023/day/12

records = []
File.open('example.txt').each do |line|
  record = line.strip.split(' ')[0]
  groups = line.strip.split(' ')[1].split(',').map(&:to_i)

  record = ((record + "?") * 5).chop
  groups = groups * 5

  mapping = {}
  groups.each_with_index do |group, index|
    mapping[index] = {
      start: 0,
      end: 0,
      size: group,
      record: record.clone,
      next_group: index + 1 == groups.length ? nil : index + 1,
      group_id: index
    }
  end

  records << mapping
end

# Checks if start and end fits in the record
def does_it_fit?(start_index, end_index, record)

  return false if start_index != 0 && record[start_index - 1] == '#' 

  (start_index..end_index).each do |position|
    return false if ['.', nil].include?(record[position])
  end

  return true if record[end_index + 1] != '#'

  false
end

arrangements = 0

records.each do |record|
  queue = [record[0]]

  memo = {}
  local_arrangements = 0
  while !queue.empty?
    group = queue.pop

    if group[:start] == 0 && group[:end] == 0
      group[:start] = 0
      group[:end] = group[:start] + (group[:size] - 1)
    end

    key = "#{group[:group_id]}  #{group[:start]}  #{group[:end]}  #{group[:record]}"
    fits = false
    if memo[key].nil?
      fits = does_it_fit?(group[:start], group[:end], group[:record])
      memo[key] = fits
    else
      fits = memo[key]
    end

    # fits = does_it_fit?(group[:start], group[:end], group[:record])

    group[:start] += 1
    group[:end] += 1
  
    if fits
      if group[:next_group]
        next_group = record[group[:next_group]]
        next_group[:start] = group[:end]
        next_group[:end] = next_group[:start] + (next_group[:size] - 1)
        next_group[:record] = group[:record].clone
        next_group[:record][group[:end] - 1] = '#'

        key = "#{next_group[:group_id]} #{next_group[:start] + 1} #{next_group[:end] + 1}"
        if memo[key]
          arrangements += 1
        else
          queue << group
          queue << next_group
        end
        
      else
        final_record = record[0][:record].clone
        record.each do |k, v|
          final_record[ (v[:start] - 1)..(v[:end] - 1) ] = 'D'*v[:size]
        end
  
        if !final_record.include?('#')
          
          # Save Cache with state
          record.each do |k, v|
            key = "#{v[:group_id]} #{v[:start]} #{v[:end]}"
            memo[key] = true
          end

          arrangements += 1
          local_arrangements += 1
        end

        queue << group
      end
    else
      if group[:start] + group[:size] <= group[:record].length
        queue << group
      end
    end

  end
end

pp arrangements