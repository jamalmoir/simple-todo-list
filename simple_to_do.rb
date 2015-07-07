require list.rb

def load_lists()
  dir = "./.to_do_lists/"
  Dir.mkdir(dir) unless File.exists?(dir)
  files = Dir.entries(dir).select{|file| /[a-z]+.tdl/.match file }
  lists = []

  files.each do |file|


  return files
end

def main()
  files = load_lists

  puts "Welcome Simple To Do List"
end
