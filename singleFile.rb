#!/usr/bin/ruby
# TODO - HANDLE EMPTY VALUES by the USER
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
oldPercentOff = ""

# NEED TO CHANGE NUMBERS TO STRINGS
newCid1.to_s
newCid2.to_s
newCid3.to_s

file = File.open(your_file+".html")
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
txt.match(/culture=[a-zA-Z]{2}-[a-zA-Z]{2}/) do |line|
     newline = line.to_s.split("=")
     oldCulture = (newline[1])
end



# SCAN FOR PRICES
txt.scan(/[a-zA-Z]*[$]\d*.\d*/) do |line|
     newline = line.to_s.split("$")
     tempOldPrices.push(newline[1])
end



# TAKING THE COUNTRY INITIALS (ie. NZ)
txt.match(/[A-Z]*[$]\d*/) do |line|
     newline = line.to_s.split("$")
     oldCountry = (newline[0])
end


# PERCENT OFF
txt.scan(/\d\d%\s/) do |line|
  newline = line.to_s.split("%")
  oldPercentOff = (newline[0])
end



oldPrices = tempOldPrices.reject { |a| a.nil? }


# oldPrices.each_with_index do |price, index|
#   puts "ALL PRICES: #{index}: #{price}"
# end

oldPrice1 = oldPrices[0]
oldPrice2 = oldPrices[6]
oldPrice3 = oldPrices[9]

strikePrice1 = oldPrices[1]
strikePrice2 = oldPrices[5]
strikePrice3 = oldPrices[8]

oldSavePrice1 = oldPrices[4].gsub("<", "")
oldSavePrice2 = oldPrices[7].gsub("<", "")
oldSavePrice3 = oldPrices[10].gsub("<", "")

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
print "Current Culture: " + oldCulture.to_s + "\n\n"
print "Current CIDs\n" + "1) #{oldCid1}\n2) #{oldCid2}\n3) #{oldCid3}\n\n" 
print "_________________NEW INPUTS_________________\n\n"

oldSavePrice1 = oldCountry+"$"+oldSavePrice1
oldSavePrice2 = oldCountry+"$"+oldSavePrice2
oldSavePrice3 = oldCountry+"$"+oldSavePrice3

oldPrice1     = oldCountry+"$"+oldPrice1
oldPrice2     = oldCountry+"$"+oldPrice2
oldPrice3     = oldCountry+"$"+oldPrice3

strikePrice1  = oldCountry+"$"+ strikePrice1
strikePrice2  = oldCountry+"$"+ strikePrice2
strikePrice3  = oldCountry+"$"+ strikePrice3

puts

# USER INPUTS 

print "Country Price (ie. NZ$79.95): "
newCountry = $stdin.gets.chomp()

# PACKAGE PRICES
print "PRICE 1 (ie. 75.95): "
newPrice1 = $stdin.gets.chomp() 

print "PRICE 2: "
newPrice2 = $stdin.gets.chomp() 

print "PRICE 3: "
newPrice3 = $stdin.gets.chomp() 

# MSRP PRICES
print "MSRP 1 (ie. 75.95): "
newStrikePrice1 = $stdin.gets.chomp()

print "MSRP 2: "
newStrikePrice2 = $stdin.gets.chomp()

print "MSRP 3: "
newStrikePrice3 = $stdin.gets.chomp()


# ALL THIS ORDEAL FOR A PERCENTAGE CALCULATION
newPercentOff = 0.0
newPercentOff = [newPrice1.to_f / newStrikePrice1.to_f]*100
newPercentOff = (newPercentOff[0]*10).ceil/10.0
newPercentOff = newPercentOff*100
newPercentOff = 100-newPercentOff
newPercentOff = newPercentOff.to_i

oldPercentOff = oldPercentOff.to_s+"%"+" "
newPercentOff = newPercentOff.to_s+"%"+" "

puts "OLDPERCENT OFF: " + oldPercentOff
puts "NEW PERCENT OFF: " + newPercentOff

# PRICE ON HOW MUCH YOU'LL BE SAVING
newSavePrice1 = newStrikePrice1.to_i - newPrice1.to_i
newSavePrice2 = newStrikePrice2.to_i - newPrice2.to_i
newSavePrice3 = newStrikePrice3.to_i - newPrice3.to_i

newSavePrice1 = newCountry+"$"+newSavePrice1.to_s
newSavePrice2 = newCountry+"$"+newSavePrice2.to_s
newSavePrice3 = newCountry+"$"+newSavePrice3.to_s

puts "Save1: " + newSavePrice1.to_s
puts "Save2: " + newSavePrice2.to_s
puts "Save3: " + newSavePrice3.to_s

newPrice1 = newCountry+"$"+newPrice1
newPrice2 = newCountry+"$"+newPrice2
newPrice3 = newCountry+"$"+newPrice3

newStrikePrice1 = newCountry+"$"+newStrikePrice1
newStrikePrice2 = newCountry+"$"+newStrikePrice2
newStrikePrice3 = newCountry+"$"+newStrikePrice3

 

# CULTURE CODE
print "New culture (ie. es-us): "
newCulture = $stdin.gets.chomp() 

print "New affid (ie. 1114): "
newAffid = $stdin.gets.chomp() 

print "New CID 1 (ie. 4562548): "
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
files = Dir[your_file+".html"]
files.each do |filename|
  file_content = IO.read(filename)

	file_content.gsub!(oldCid1,newCid1)
	file_content.gsub!(oldCid2,newCid2)
	file_content.gsub!(oldCid3,newCid3)
	file_content.gsub!(oldAffid,newAffid)
	file_content.gsub!(oldCulture.to_s, newCulture.to_s)
	file_content.gsub!(oldPrice1, newPrice1)
	file_content.gsub!(oldPrice2, newPrice2)
	file_content.gsub!(oldPrice3, newPrice3)

	file_content.gsub!(strikePrice1, newStrikePrice1)
	file_content.gsub!(strikePrice2, newStrikePrice2)
	file_content.gsub!(strikePrice3, newStrikePrice3)
	
  file_content.gsub!(oldSavePrice1, newSavePrice1)
  file_content.gsub!(oldSavePrice2, newSavePrice2)
  file_content.gsub!(oldSavePrice3, newSavePrice3)

  file_content.gsub!(oldPercentOff, newPercentOff)


  output = File.open(filename,'w')
  output.write(file_content)
  output.close
end
exit