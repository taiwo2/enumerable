# rubocop:disable Style/CaseEquality
module Enumerable
  def my_each
    return enum_for unless block_given?

    idx = 0

    arr ||= to_a
    while idx < arr.length
      yield(arr[idx])
      idx += 1
    end

    self
  end

  def my_each_with_index
    return enum_for unless block_given?

    idx = 0

    arr ||= to_a
    while idx < arr.length
      yield(arr[idx], idx)
      idx += 1
    end

    self
  end

  def my_select
    return enum_for unless block_given?

    selected = []
    my_each do |el|
      selected << el if yield(el)
    end
    selected
  end

  def my_all?(arg = nil)
    if arg
      my_each { |ele| return false unless arg === ele }
    elsif block_given?
      my_each { |ele| return false unless yield(ele) }
    else
      my_each { |ele| return false unless ele }
    end
    true
  end

  def my_any?(arg = nil)
    if arg
      my_each { |ele| return true if arg === ele } # rubocop:disable Style/CaseEquality
    elsif block_given?
      my_each { |ele| return true if yield(ele) }
    else
      my_each { |ele| return true if ele }
    end
    false
  end

  def my_none?(arg = nil, &block)
    !my_any?(arg, &block)
  end

  def my_count(arg = nil, &prc)
    counted = 0
    if block_given?
      my_each { |ele| counted += 1 if prc.call(ele) }
    elsif !block_given? && arg.nil?
      counted = to_a.length
    else
      counted = to_a.my_select { |ele| ele == arg }.length
    end
    counted
  end

  def my_map(proc = nil)
    return enum_for unless block_given?

    list = is_a?(Range) ? to_a : self
    mapped = []
    if proc
      list.my_each { |ele| mapped << proc.call(ele) }
    else
      list.my_each { |ele| mapped << yield(ele) }
    end
    mapped
  end

  def my_inject(*args)
    reduce = args[0] if args[0].is_a?(Integer)
    operator = args[0].is_a?(Symbol) ? args[0] : args[1]
    if operator
      to_a.my_each { |item| reduce = reduce ? reduce.send(operator, item) : item }
      return reduce
    end
    to_a.my_each { |item| reduce = reduce ? yield(reduce, item) : item }
    reduce
  end
end

def multiply_els(arr)
  arr.my_inject(:*)
end
# rubocop:enable Style/CaseEquality
