class ToDoList
  attr_accessor :id, :name, :path

  def get_content()
    return File.readlines(:path)
  end

  def empty?()
    get_content() == nil ? true : false
  end

  def add(todo)
    @file = open(:path, 'a')
    @file.puts(todo)
    @file.close
  end

  def remove(id)
    @content = get_content
    @content.delete(id)
    @file = open(:path, 'w')

    @content.each do |line|
      file.puts(line + "\n")
    end

    @file.close
  end
end