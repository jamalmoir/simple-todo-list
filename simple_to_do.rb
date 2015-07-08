require './to_do_list'

def load_lists()
  dir = "./.to_do_lists/"
  Dir.mkdir(dir) unless File.exists?(dir)
  files = Dir.entries(dir).select{|file| /[a-z]+.tdl/.match file }
  lists = Array.new

  files.each_with_index do |file, index|
    @extname = File.extname file
    @name = File.basename file , @extname
    @path = "./.to_do_lists/" + File.basename(file)
    lists.push(ToDoList.new(index, @name, @path))
  end

  return lists
end

def add_list(name)
  file = File.new(name, 'w')
  file.close
  load_lists
end

def remove_list(name)
  File.delete("./.to_do_lists/" + name + ".tdl")
end

files = load_lists
stay_open = true

puts "Welcome To Simple To Do List"

while stay_open
  
end