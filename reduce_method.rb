def reduce(array, default=nil)
  counter = 0

  if default
    acc = default
  else
    counter += 1
    acc = array[0]
  end
  
  while counter < array.size
    acc = yield(acc, array[counter])
    counter += 1
  end

  acc
end


array = [1, 2, 3, 4, 5]
p reduce(array) { |acc, num| acc + num }
p reduce(array, 10) { |acc, num| acc + num }
# p reduce(array) { |acc, num| acc + num if num.odd? }
p reduce(['a', 'b', 'c']) { |acc, value| acc += value }
p reduce([[1, 2], ['a', 'b']]) { |acc, value| acc + value }