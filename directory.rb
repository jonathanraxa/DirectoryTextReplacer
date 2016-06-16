#!/usr/bin/ruby

directory = ""
arg2 = "" 
arg3 = ""
answer = ""
currentPromo = ""
newPromo = ""
currentPromoContext = ""
newPromoContext = ""
promo = false

# Get user input
print "Directory name: "
directory = $stdin.gets.chomp()




#Check to determine if argument is a directory
if (File::directory?( directory ))
  print "Success, processing directory: " + directory
else
  print "Sorry, not a directory"
end

puts 

print "Are you changing a PROMO code? (y/n): "
answer =  $stdin.gets.chomp()
if answer == "y"
	promo = true
end


if (promo == true)

	print "Current PROMO: "
	currentPromo = $stdin.gets.chomp()
	currentPromo = currentPromo

	print "New PROMO: "
	newPromo = $stdin.gets.chomp()
	newPromo = newPromo.upcase
	
	currentPromoContext = "name=\"promo\" value=\""+ currentPromo +"\""
    newPromoContext 	= "name=\"promo\" value=\""+ newPromo +"\""
    
    currentCommentPromoCode = "<!--promocode-->" + currentPromo
    newCommentPromoCode = "<!--promocode-->"+ newPromo

    currentPromo = "promo="+currentPromo
    newPromo = "promo="+newPromo

    puts currentPromo
    puts newPromo
    puts currentPromoContext
    puts newPromoContext
    puts currentCommentPromoCode
    puts newCommentPromoCode

	# GLOB files handled: txt,cfm,html,asp,js,php
	Dir.glob(directory+"**/**/*.{txt,cfm,html,asp,js,php}") do |file|
		puts "Searching: #{file}"
		
		File.open(file) { |source_file|
			contents = source_file.read
		 	contents.gsub!(currentPromo, newPromo)
		 	contents.gsub!(currentPromoContext, newPromoContext)
		 	contents.gsub!(currentCommentPromoCode, newCommentPromoCode)
			File.open(file, "w+") { |f| f.write(contents) }

		} # end file-open 
	end # end Dir.glob
	abort("All finished Sir!")
end 



print "To Replace: "
arg2 = gets.chomp()

print "Replace With: "
arg3 = gets.chomp()



# GLOB files handled: txt,cfm,html,asp,js,php
Dir.glob(directory+"**/**/*.{txt,cfm,html,asp,js,php}") do |file|
	puts "Searching: #{file}"
	
	File.open(file) { |source_file|
		contents = source_file.read
	 	contents.gsub!(arg2, arg3)
		File.open(file, "w+") { |f| f.write(contents) }
	} # end file-open 
end # end Dir.glob



