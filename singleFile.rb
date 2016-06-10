#!/usr/bin/ruby

cids = Array.new(6)
tempOldPrices = Array.new(6)
oldPrices = Array.new(6)
new_cids = Array.new(6)
your_file = ARGV[0]
oldAffid = ""
newAffid = ""
oldCulture = ""
newCulture = ""
newCid1 = ""
newCid2 = ""
newCid3 = ""
newPrice1 = ""
newPrice2 = ""
newPrice3 = ""
strikePrice1 = ""
strikePrice2 = ""
strikePrice3 = ""
newStrikePrice1 = ""
newStrikePrice2 = ""
newStrikePrice3 = ""
oldCountry = ""
newCountry = ""


# NEED TO CHANGE NUMBERS TO STRINGS
newCid1.to_s
newCid2.to_s
newCid3.to_s

file = File.open(your_file)
txt = file.read()

# SPLITS CID AT "=" AND PUSHES NUMBER TO ARRAY
txt.scan(/cid=\d\d\d\d\d\d/) do |line|
    line.split("=")
    cids.push(line[4..9])
end

txt.scan(/affid=\d\d\d\d/) do |line|
     line.split("=")
     oldAffid = (line[6..9])
end


# FOR SOME REASON MATCH WORKS INSTEAD OF SCAN
txt.match(/[culture=]+([en]{2}|[pt]{2}|[es]{2})[\-]{1}[a-zA-Z]{2}/) do |line|
     newline = line.to_s.split("=")
     oldCulture = (newline[1])
end

# SCAN FOR PRICES
txt.scan(/[a-zA-Z]*[$]\d*.\d{2}/) do |line|
     newline = line.to_s.split("$")
     tempOldPrices.push(newline[1])
end

# TAKING THE COUNTRY INITIALS (ie. NZ)
txt.match(/[A-Z]*[$]\d*/) do |line|
     newline = line.to_s.split("$")
     oldCountry = (newline[0])
end


oldPrices = tempOldPrices.reject { |a| a.nil? }


oldPrice1 = oldPrices[3]
oldPrice2 = oldPrices[5]
oldPrice3 = oldPrices[7]


strikePrice1 = oldPrices[2]
strikePrice2 = oldPrices[4]
strikePrice3 = oldPrices[6]


file.close

# CREATE AN ARRAY OF CIDS TO BE REPLACED
# not entirely necessary but may be useful for future use
temp_cids = cids.reject { |a| a.nil? }
puts
oldCid1 = temp_cids[1]
oldCid2 = temp_cids[2]
oldCid3 = temp_cids[3]


print "\n\n"
puts "MODIFYING FILE: #{your_file}\n\n"
print "Current Country: #{oldCountry}\n\n"
print "Current Prices\n" + "#{oldPrice1}\n#{oldPrice2}\n#{oldPrice3}\n\n" 
print "Current MSRP Prices\n" + "#{strikePrice1}\n#{strikePrice2}\n#{strikePrice3}\n\n" 
print "Current AFFID: " + oldAffid + "\n\n" 
print "Current Culture: " + oldCulture + "\n\n"
print "Current CIDs\n" + "1) #{oldCid1}\n2) #{oldCid2}\n3) #{oldCid3}\n\n" 
print "_________________NEW INPUTS_________________\n\n"

# # USER INPUTS 
print "Country: "
newCountry = $stdin.gets.chomp()

print "PRICE 1: "
newPrice1 = $stdin.gets.chomp() 
newPrice1 = newCountry+"$"+newPrice1

print "PRICE 2: "
newPrice2 = $stdin.gets.chomp() 
newPrice2 = newCountry+"$"+newPrice2

print "PRICE 3: "
newPrice3 = $stdin.gets.chomp() 
newPrice3 = newCountry+"$"+newPrice3

oldPrice1 	 = oldCountry+"$"+oldPrice1
oldPrice2 	 = oldCountry+"$"+oldPrice2
oldPrice3 	 = oldCountry+"$"+oldPrice3

strikePrice1 = oldCountry+"$"+oldPrice1
strikePrice2 = oldCountry+"$"+oldPrice2
strikePrice3 = oldCountry+"$"+oldPrice3

puts

puts newPrice1
puts newPrice2
puts newPrice3


print "MSRP 1: "
newStrikePrice1 = $stdin.gets.chomp()
newStrikePrice1 = newCountry+"$"+newStrikePrice1

print "MSRP 2: "
newStrikePrice2 = $stdin.gets.chomp()
newStrikePrice2 = newCountry+"$"+newStrikePrice2

print "MSRP 3: "
newStrikePrice3 = $stdin.gets.chomp()
newStrikePrice3 = newCountry+"$"+newStrikePrice3

print "New culture (ie. es-us): "
newCulture = $stdin.gets.chomp() 

print "New affid: "
newAffid = $stdin.gets.chomp() 

print "New CID 1: "
newCid1 = $stdin.gets.chomp()

print "New CID 2: "
newCid2 = $stdin.gets.chomp()

print "New CID 3: "
newCid3 = $stdin.gets.chomp()

puts
puts "New AFFID: " + newAffid
puts 
puts "New Culture: " + newCulture
puts
puts "New CIDs: "
puts "1) " + newCid1
puts "2) " + newCid2
puts "3) " + newCid3

# WHERE ALL CIDs/AFFID/CULTURE CODES ARE REPLACED
files = Dir[your_file]
files.each do |filename|
  file_content = IO.read(filename)

	file_content.gsub!(oldCid1,newCid1)
	file_content.gsub!(oldCid2,newCid2)
	file_content.gsub!(oldCid3,newCid3)
	file_content.gsub!(oldAffid,newAffid)
	file_content.gsub!(oldCulture, newCulture)
	file_content.gsub!(oldPrice1, newPrice1)
	file_content.gsub!(oldPrice2, newPrice2)
	file_content.gsub!(oldPrice3, newPrice3)
	file_content.gsub!(strikePrice1, newStrikePrice1)
	file_content.gsub!(strikePrice2, newStrikePrice2)
	file_content.gsub!(strikePrice3, newStrikePrice3)
	

  output = File.open(filename,'w')
  output.write(file_content)
  output.close
end
exit