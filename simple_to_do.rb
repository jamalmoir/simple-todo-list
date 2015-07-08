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

def load_list(id)
  return load_lists[id.to_i]
end

def print_options
  puts "\n____Options____"
    puts "0 : Create List"
    puts "1 : Delete List"
    puts "2 : Select List"
    puts "q : Exit"
end

def print_list_options
  puts "\n____Options____"
  puts "0 : Add Item"
  puts "1 : Remove Item"
  puts "x : Exit"
end

def print_lists
  files = load_lists
  puts "\n____Lists____"

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
      remove_list(get_input "Enter The ID Of List To Delete : ")
      puts "Removed."
    when "2"
      print_lists
      current_list = load_list(get_input "Enter The ID Of A List : ")
    when "q"
      exit
    else
      puts "Invalid Choice"
    end
  else
    puts "\n____#{current_list.name}____"
    current_list.get_content.each_with_index do |item, index|
      puts "#{index} : #{item}"
    end

    print_list_options
    input = get_input "Choose An Option : "

    case input
    when "0"
      current_list.add(get_input "Enter A New Item : ")
    when "1"
      current_list.remove((get_input "Enter ID Of Item To Delete : ").to_i)
    when "x"
      current_list = nil
    else
      puts "Invalid Choice"
    end
  end
end