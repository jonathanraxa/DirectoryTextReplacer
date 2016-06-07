#!/usr/bin/ruby
directory = ""
arg2 = "" 
arg3 = ""

# Get user input
print "Directory name: "
directory = gets.chomp()

print "To Replace: "
arg2 = gets.chomp()

print "Replace With: "
arg3 = gets.chomp()

#Check to determine if argument is a directory
if (File::directory?( directory ))
  print "Success, processing directory: " + directory
else
  print "Sorry, not a directory"
end

puts 

# GLOB files handled: txt,cfm,html,asp,js,php
Dir.glob(directory+"**/**/*.{txt,cfm,html,asp,js,php}") do |file|
	puts "Searching: #{file}"
	
	File.open(file) { |source_file|
		contents = source_file.read
	 	contents.gsub!(arg2, arg3)
		File.open(file, "w+") { |f| f.write(contents) }
	} # end file-open 
end # end Dir.glob



