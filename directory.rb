#!/usr/bin/ruby

directory = ARGV[0]
arg2 = ARGV[1]
arg3 = ARGV[2]


# check to determine if argument is a directory
if (File::directory?( directory ))
  print "Success, processing directory: " + directory
else
  print "Sorry, not a directory"

end

puts 

# GLOB (cfm, asp, html)
Dir.glob(directory+"/**.txt") do |file|
	puts "Searching: #{file}"
	
	File.open(file) { |source_file|
		contents = source_file.read
	 	contents.gsub!(arg2, arg3)
		File.open(file, "w+") { |f| f.write(contents) }
	} # end file-open 
end # end Dir.glob



# where the magic happens to each file within the directory
# Dir.foreach(directory){
#   |files|
  
# 	if(files != '.' && files != '..')
# 	  File.open(directory+'/'+files) { |source_file|
# 	  contents = source_file.read
# 	  contents.gsub!(arg2, arg3)
# 	  File.open(directory+'/'+files, "w+") { |f| f.write(contents) }
# 	}    
#   end # end if-statement
# } # end Dir foreach 
