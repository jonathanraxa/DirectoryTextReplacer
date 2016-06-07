#!/usr/bin/ruby
# TODO: change this to a directory
#your_file = ARGV.first

#your_file = /#{Regexp.quote("input.txt")}/

# argument input inside command line



directory = ARGV.first



# check to determine if argument is a directory
if (File::directory?( directory ))
  print "Success, processing directory: " + directory
else
  print "Sorry, not a directory"
end

puts 

print "Entires: " + Dir.entries(directory).join(' ')

puts 
puts 


# puts "Text to replace: "
# arg2 = gets
# arg2.chomp

# puts "Text desired: "
# arg3 = gets
# arg3.chomp



# where the magic happens to each file within the directory
Dir.foreach(directory){
  |files|
  
	# puts "Got #{files} "
	if(files != '.' && files != '..')
	  File.open(directory+'/'+files) { |source_file|
	  contents = source_file.read
	  contents.gsub!(/IT/, "arg3")
	  File.open(directory+'/'+files, "w+") { |f| f.write(contents) }
	}    
  end # end if-statement
} # end Dir foreach 
