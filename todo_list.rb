class Todo
  DONE_MARKER = 'X'
  UNDONE_MARKER = ' '

  attr_accessor :title, :description, :done

  def initialize(title, description='')
    @title = title
    @description = description
    @done = false
  end

  def done!
    self.done = true
  end

  def done?
    done
  end

  def undone!
    self.done = false
  end

  def to_s
    "[#{done? ? DONE_MARKER : UNDONE_MARKER}] #{title}"
  end

  def ==(other_todo)
    title == other_todo.title &&
      description == other_todo.description &&
      done == other_todo.done
  end
end

class TodoList
  attr_accessor :title

  def initialize(title)
    @title = title
    @todos = []
  end

  def each
    counter = 0

    while counter < @todos.size
      yield(@todos[counter])
      counter += 1
    end

    self
  end

  def select
    result = TodoList.new('Temp')

    each do |todo|
      result << todo if yield(todo)
    end

    result
  end

  def find_by_title(string)
    each do |todo|
      return todo if todo.title.casecmp?(string)
    end

    nil
  end

  def all_done
    select(&:done?)
  end

  def all_not_done
    select { |todo| !todo.done? }
  end

  def mark_done(string)
    todo = find_by_title(string)
    todo.done! if todo
  end

  def mark_all_undone
    each(&:undone!)
  end

  def add(todo)
    raise TypeError.new("Can only add Todo objects") unless todo.is_a?(Todo)
    @todos << todo
  end

  alias_method :<<, :add

  def size
    @todos.length
  end

  def first
    @todos.first
  end

  def last
    @todos.last
  end

  def to_a
    @todos.clone
  end

  def done?
    @todos.all?(&:done?)
  end

  def item_at(idx)
    @todos.fetch(idx)
  end

  def mark_done_at(idx)
    item_at(idx).done!
  end

  def mark_undone_at(idx)
    item_at(idx).undone!
  end

  def done!
    each(&:done!)
  end
  alias_method :mark_all_done, :done!

  def shift
    @todos.shift
  end

  def pop
    @todos.pop
  end

  def remove_at(idx)
    @todos.delete(item_at(idx))
  end

  def to_s
    string = "---- #{title} ----\n"
    @todos.each do |todo|
      string << (todo.to_s + "\n")
    end

    string
  end
end

todo1 = Todo.new("Buy milk")
todo2 = Todo.new("Clean room")
todo3 = Todo.new("Go to gym")

list = TodoList.new("Today's Todos")
list.add(todo1)
list.add(todo2)
list.add(todo3)

# puts list.find_by_title('buy milk')
# p list.find_by_title('waka waka waka')

# list.mark_all_done

# puts list.all_done
# puts list.all_not_done

# list.mark_all_undone

# puts list.all_done
# puts list.all_not_done