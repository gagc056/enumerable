# frozen_string_literal: true

require './enumerable'

arr = [1, 2]
puts 'my_each'
arr.my_each do |num|
  puts num / num
end

puts 'my_each_with_index'
puts "my_each_with_index case #{[1, 2, "b", "c"].each_with_index { |n,e| puts n,e }}"

puts 'my_select'
array = [1.0, 2.3, 4.2]
test = array.my_select do |num|
  num.to_i.positive && num.to_i < 4
end
puts test

puts 'my_all?'
puts "my_all? case1 #{%w[ant bear cat].all? { |word| word.length >= 3 }}"
puts "my_all? case2 #{%w[ant bear cat].all? { |word| word.length >= 4 }}"
puts "my_all? case3 #{%w[ant bear cat].all?(/t/)}"
puts "my_all? case1 #{[1, 2i, 3.14].all?(Numeric)}"
puts "my_all? case1 #{[nil, true, 99].all?}"

puts 'my_any?'
puts "my_any? case 1 #{%w[ant bear cat].any? { |word| word.length >= 3 }}"
puts "my_any? case 2 #{%w[ant bear cat].any? { |word| word.length >= 4 }}"
puts "my_any? case 3 #{%w[ant bear cat].any?(/d/)}"
puts "my_any? case 4 #{[nil, true, 99].any?(Integer)}"
puts "my_any? case 5 #{[nil, true, 99].any?}"
puts "my_any? case 6 #{[].any?}"

puts 'my_none?'
puts "my_none? case 1 #{%w[ant bear cat].none? { |word| word.length == 5 }}"
puts "my_none? case 2 #{%w[ant bear cat].none? { |word| word.length >= 4 }}"
puts "my_none? case 3 #{%w[ant bear cat].none?(/d/)}"
puts "my_none? case 4 #{%w[1, 3.14, 42].none?(Float)}"
puts "my_none? case 5 #{[].none?}"
puts "my_none? case 5 #{[nil].none?}"
puts "my_none? case 6 #{[nil, false].none?}"
puts "my_none? case 6 #{[nil, false, true].none?}"

puts 'my_count'
arr = [1, 2, 4, 2]
puts "my_count case 1 #{arr.my_count}"
puts "my_count case 2 #{arr.my_count(2)}"
puts "my_count case 3 #{arr.my_count{ (x % 2).zero? }}"

puts 'my_map'
puts " my_map case #{[1, 2, 3].map { |n| n * 2 }}"

puts '*** my_inject ***'
puts"my inject case 1 #{((5..10).my_inject { |sum, n| sum + n })}"
puts"my inject case 2 #{(5..10).my_inject(1) { |product, n| product * n }}"

longest = %w[cat sheep bear].inject do |memo, word|
  memo.length > word.length ? memo : word
end
puts longest

puts
def multiply_els(arr)
  arr.my_inject(:*)
end
