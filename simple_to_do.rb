require './to_do_list'

PATH_TO_LISTS = "./.to_do_lists/"
EXT = ".tdl"

def load_lists()
  Dir.mkdir(PATH_TO_LISTS) unless File.exists?(PATH_TO_LISTS)
  files = Dir.entries(PATH_TO_LISTS).select{|file| /[A-Za-z\d_-]+.tdl/.match file }
  lists = Array.new

  files.each_with_index do |file, index|
    @extname = File.extname file
    @name = File.basename file , @extname
    @path = PATH_TO_LISTS + File.basename(file)
    lists.push(ToDoList.new(index, @name, @path))
  end

  return lists
end

def add_list(name)
  file = File.new(PATH_TO_LISTS + name + EXT, 'w')
  file.close
  load_lists
end

def remove_list(id)
  files = load_lists
  name = files[id.to_i].name
  File.delete(PATH_TO_LISTS + name + EXT)
end

def print_options
  puts "____Options____"
    puts "0 : Create List"
    puts "1 : Delete List"
    puts "2 : Select List"
end

def print_lists
  files = load_lists
  puts "____Lists____"

  files.each do |item|
    print "#{item.id} : #{item.name}\n"
  end
end

def get_input(text)
  print text
  input = gets.to_s.chomp
  return input
end

run = true
current_list = nil

puts "Welcome To Simple To Do List"

while run
  if current_list == nil
    print_options
    input = get_input "Choose An Option : "

    case input
    when "0"
      add_list(get_input "Enter A Name For New List : ")
      puts "Added"
    when "1"
      print_lists
      remove_list(get_input "Enter The ID Of The List You Wish To Delete : ")
      puts "Removed."
    when "2"
      print_lists
      choice = get_input "Enter The Idea Of A List : "
    when "3"
    else
    end
  end
end