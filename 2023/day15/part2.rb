# frozen_string_literal: true
# https://adventofcode.com/2023/day/15

data = []
File.open('example.txt').each_with_index do |line, index|
  data << line.strip.split(',')
end

def get_it(char, previous)
  (previous + char.ord) * 17 % 256
end

def get_label(label)
  x = 0
  label.each_char do |char|
    x = get_it(char, x)
  end
  x
end

boxes = []
data.flatten.each do |part|
  if part.include?('=')
    instruction = part.split('=')
    label = instruction[0]
    focal = instruction[1]

    position = get_label(label)
    if boxes[position].nil?
      boxes[position] = [[label, focal]]
    else
      replace = false
      boxes[position].each do |box|
        if box[0] == label
          box[1] = focal
          replace = true
        end
      end

      if !replace
        boxes[position] << [label, focal]
      end
    end
  else
    instruction = part.split('-')
    label = instruction[0]
    position = get_label(label)

    if boxes[position].nil?
      # Nothing to do
    else
      remove_lens = false
      remove_index = -1

      boxes[position].each_with_index do |box, index|
        if box[0] == label
          remove_lens = true
          remove_index = index
          break
        end
      end

      if remove_lens
        boxes[position].delete_at(remove_index)
      end
    end
  end
end

acc = 0
boxes.each_with_index do |box, box_index|
  slot_number = 1
  box ||= []
  box.each do |labels|
    acc += (box_index + 1) * slot_number * labels[1].to_i
    slot_number += 1
  end
end

pp acc
