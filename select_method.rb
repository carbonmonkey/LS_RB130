def select(array)
  counter = 0
  result = []

  while counter < array.size
    flag = yield(array[counter])
    result << array[counter] if flag
    counter += 1
  end
  
  result
end

arr = [1, 2, 3, 4, 5]
p select(arr) { |num| num.odd? }
p select(arr) { |num| puts num }
p select(arr) { |num| num + 1 }