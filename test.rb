# frozen_string_literal: true

require './enumerable'
a = ([1, 2, 'b', 'c'].each_with_index { |n, e| puts n, e }).to_s
puts a

puts(%w[ant bear cat].all? { |word| word.length >= 3 }).to_s
puts(%w[ant bear cat].all? { |word| word.length >= 4 }).to_s
puts %w[ant bear cat].all?(/t/)
puts [1, 2i, 3.14].all?(Numeric)
puts [nil, true, 99].all?

puts(%w[ant bear cat].any? { |word| word.length >= 3 }).to_s
puts(%w[ant bear cat].any? { |word| word.length >= 4 }).to_s
puts %w[ant bear cat].any?(/d/)
puts [nil, true, 99].any?(Integer)
puts [nil, true, 99].any?
puts [].any?

puts(%w[ant bear cat].none? { |word| word.length == 5 }).to_s
puts(%w[ant bear cat].none? { |word| word.length >= 4 }).to_s
puts %w[ant bear cat].none?(/d/)
puts %w[1 3.14 42].none?(Float)
puts [].none?
puts [nil].none?
puts [nil, false].none?
puts [nil, false, true].none?

arr = [1, 2, 4, 2]
puts arr.my_count
puts arr.my_count(2)
puts(arr.my_count { |x| (x % 2).zero? }).to_s

puts([1, 2, 3].map { |n| n * 2 }).to_s

puts((5..10).reduce(:+)).to_s
puts((5..10).inject { |sum, n| sum + n }).to_s
puts((5..10).reduce(1, :*)).to_s
puts((5..10).inject(1) { |product, n| product * n }).to_s

longest = %w[cat sheep bear].my_inject do |memo, word|
  memo.length > word.length ? memo : word
end
puts longest
