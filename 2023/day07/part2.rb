# frozen_string_literal: true
# https://adventofcode.com/2023/day/7

def get_hand_type(hand)
  cards = {}
  hand.each_char do |char|
    if cards[char] == nil
      cards[char] = 1
    else
      cards[char] += 1
    end
  end
  
  # Fit in Joker here, remove J key, add it to the biggest key instead
  if cards.has_key?('J') && cards['J'] != 5
    puts "Before: #{cards}"
    j_count = cards['J']
    cards.delete('J')

    last = cards.sort_by{|k, v| v}.last
    cards[last[0]] += j_count

    puts "After: #{cards}"
  end
  
  case cards.keys.count
  when 5
    1
  when 4
    2
  when 3
    if cards.values[0] == 3 || cards.values[1] == 3 || cards.values[2] == 3
      4
    else
      3
    end
  when 2
    if cards.values[0] == 4 || cards.values[1] == 4
      6
    else
      5
    end
  when 1
    7
  else
    9999
  end
end

map_values = {
  "2" => 2,
  "3" => 3,
  "4" => 4,
  "5" => 5,
  "6" => 6,
  "7" => 7,
  "8" => 8,
  "9" => 9,
  "T" => 10,
  "J" => 1,
  "Q" => 12,
  "K" => 13,
  "A" => 14,
}

hands = []
File.open('input.txt').each do |line|
  hand = line.strip.split(' ')[0]
  bet = line.strip.split(' ')[1].to_i

  hands << {
    hand: hand,
    type: get_hand_type(hand),
    rank: nil,
    bet: bet,
    high1: map_values[hand[0]],
    high2: map_values[hand[1]],
    high3: map_values[hand[2]],
    high4: map_values[hand[3]],
    high5: map_values[hand[4]]
  }
end

def sort_hands(hands)
  hands.sort_by do |hand|
    [hand[:high1],hand[:high2],hand[:high3],hand[:high4],hand[:high5]]
  end
end

winnings = []
current_hand = 0
(1..7).each do |type|
  found = hands.select{|hand| hand[:type] == type}
  sorted_hands = sort_hands(found)

  sorted_hands.each do |hand|
    current_hand += 1
    winnings << (hand[:bet] * current_hand)
  end
end

puts winnings.sum
