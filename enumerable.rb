# frozen_string_literal: true

module Enumerable # rubocop:disable Metrics/ModuleLength
  def my_each
    return to_enum unless block_given?

    i = 0
    while i < size
      yield(self[i])
      i += 1
    end
    self
  end

  def my_each_with_index
    return to_enum :my_each_with_index unless block_given?

    i = 0
    my_each { |x| yield x, i, i += 1 }
    self
  end

  def my_select
    return enum_for :my_select unless block_given?

    Enumerator.new do |y|
      my_each { |item| y << item if yield item }
    end.to_a
  end

  def my_all?(*arg)
    if block_given?
        self.my_each do |i|
            return false if !yield(i)
        end
        return true
    elsif arg.length > 0
        if arg[0].is_a? Numeric
            self.my_each do |i|
                return false if i != arg[0]
            end
            return true
        elsif arg[0].class == Regexp
            self.my_each do |i|
                return false if !(i =~ arg[0])
            end
            return true
        else
            self.my_each do |i|
                return false if !(i.is_a? arg[0])
            end
            return true
        end
    else
        self.my_each do |i|
            return false if i == nil || i == false
        end
        return true
    end
  end

  def my_any?(param = nil)
    if block_given?
      my_each { |i| return true if yield(i) }
    elsif param.class == Class
      my_each { |i| return true if i.class == param }
    elsif param.class == Regexp
      my_each { |i| return true if i =~ param }
    elsif param.nil?
      my_each { |i| return true if i }
    else
      my_each { |i| return true if i == param }
    end
    false
  end

  def my_none?(*arg)
    if block_given?
        puts "block given"
        self.my_each do |i|
            return false if yield(i)
        end
        return true
    elsif arg.length > 0
        puts "arg given"
        if arg[0].is_a? Numeric
            self.my_each do |i|
                return false if i == arg[0]
            end
            return true
        elsif arg[0].class == Regexp
            puts "Regexp"
            self.my_each do |i|
                return false if arg[0] =~ i
            end
            return true
        else
            self.my_each do |i|
                return false if (i.is_a? arg[0])
            end
            return true
        end
    else
        return true if self.length == 0
        self.my_each do |i|
            return false if i
        end
        return true
    end
  end

  def my_count(first = nil)
    count = 0
    if block_given?
      my_each { |i| count += 1 if yield(i) == true }
    elsif first.nil?
      my_each { count += 1 }
    else
      my_each { |i| count += 1 if i == first }
    end
    count
  end

  def my_map(arg = nil)
    return to_enum unless block_given?

    arr = []
    my_each do |i|
      if !arg.nil?
        arr << arg.call(i)
      else
        yield(i)
      end
    end
    arr
  end

  def my_inject(first = nil, second = nil)
    check_self = is_a?(Range) ? to_a : self
    accumulator = first.nil? || first.is_a?(Symbol) ? check_self[0] : first
    if block_given? && first
      check_self[0..-1].my_each do |item|
        accumulator = yield(accumulator, item)
      end
    end

    if block_given? && !first
      check_self[1..-1].my_each do |item|
        accumulator = yield(accumulator, item)
      end
    end

    if first.is_a?(Symbol)
      check_self[1..-1].my_each do |i|
        accumulator = accumulator.send(first, i)
      end
    end

    if second
      check_self[0..-1].my_each do |i|
        accumulator = accumulator.send(second, i)
      end
    end
    accumulator
  end
end

# rubocop:enable  Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
