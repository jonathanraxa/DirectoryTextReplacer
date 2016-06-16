#!/usr/bin/env ruby
# TODO - HANDLE EMPTY VALUES by the USER

cids = Array.new(6)
tempOldPrices = Array.new(6)
oldPrices = Array.new(6)
# new_cids = Array.new(6)
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
newSavePrice1 = ""
newSavePrice2 = ""
newSavePrice3 = ""
oldCountry = ""
newCountry = ""
oldPercentOff = ""
newPercentOff = ""

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

oldPrice1 = oldPrices[0].gsub("<", "")
oldPrice2 = oldPrices[6].gsub("<", "")
oldPrice3 = oldPrices[9].gsub("<", "")

strikePrice1 = oldPrices[1].gsub("<", "")
strikePrice2 = oldPrices[5].gsub("<", "")
strikePrice3 = oldPrices[8].gsub("<", "")

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

print "_________________NEW INPUTS_________________\n\n\n"

print "IF NO CHANGE TO VALUE, TYPE 'no' TO SKIP SECTION \n\n"

# DEFINE ALL THE OLD VALUES WITHIN THE PAGE WITH COUNTRY AND MONEY SYMBOL
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
while newCountry.empty?
  print "Country initials for PRICE (ie. [NZ] for NZ$79.95): "
  newCountry = $stdin.gets.chomp()
  if newCountry == "no"
    newCountry = ""
    p "no value"
    break
  end
end

# PACKAGE PRICES - MTP, MAS, etc
while newPrice1.empty? 
  print "PRICE 1 (ie. 75.95): "
  newPrice1 = $stdin.gets.chomp() 
  if newPrice1 == "no"
    newPrice1 = ""
    p "no value"
    break
  end
end

while newPrice2.empty? 
  print "PRICE 2: "
  newPrice2 = $stdin.gets.chomp() 
  if newPrice2 == "no"
    newPrice2 = ""
    p "no value"
    break
  end
end

while newPrice3.empty?
  print "PRICE 3: "
  newPrice3 = $stdin.gets.chomp() 
  if newPrice3 == "no"
    newPrice3 = ""
    p "no value"
    break
  end
end


# MSRP PRICES
while newStrikePrice1.empty?
  print "MSRP 1 (ie. 75.95): "
  newStrikePrice1 = $stdin.gets.chomp()
  if newStrikePrice1 == "no"
    newStrikePrice1 = ""
    p "no value"
    break
  end
end

while newStrikePrice2.empty?
  print "MSRP 2: "
  newStrikePrice2 = $stdin.gets.chomp()
  if newStrikePrice2 == "no"
    newStrikePrice2 = ""
    p "no value"
    break
  end
end

while newStrikePrice3.empty?
  print "MSRP 3: "
  newStrikePrice3 = $stdin.gets.chomp()
  if newStrikePrice3 == "no"
    newStrikePrice3 = ""
    p "no value"
    break
  end
end

# ALL THIS ORDEAL FOR A PERCENTAGE CALCULATION
if ( newStrikePrice1 == "" && newPrice1 == "" )


else
    newPercentOff = 0.0
    newPercentOff = [newPrice1.to_f / newStrikePrice1.to_f]*100
    newPercentOff = (newPercentOff[0]*10).round/10.0
    newPercentOff = newPercentOff*100
    newPercentOff = 100-newPercentOff
    newPercentOff = newPercentOff.to_i
    oldPercentOff = oldPercentOff.to_s+"%"+" "
    newPercentOff = newPercentOff.to_s+"%"+" "

    # PRICE ON HOW MUCH YOU'LL BE SAVING
    newSavePrice1 = newStrikePrice1.to_i - newPrice1.to_i
    newSavePrice2 = newStrikePrice2.to_i - newPrice2.to_i
    newSavePrice3 = newStrikePrice3.to_i - newPrice3.to_i

    newSavePrice1 = newCountry+"$"+newSavePrice1.to_s
    newSavePrice2 = newCountry+"$"+newSavePrice2.to_s
    newSavePrice3 = newCountry+"$"+newSavePrice3.to_s

    newPrice1 = newCountry+"$"+newPrice1
    newPrice2 = newCountry+"$"+newPrice2
    newPrice3 = newCountry+"$"+newPrice3

    newStrikePrice1 = newCountry+"$"+newStrikePrice1
    newStrikePrice2 = newCountry+"$"+newStrikePrice2
    newStrikePrice3 = newCountry+"$"+newStrikePrice3

 end

# CULTURE CODE
while newCulture.empty?
  print "New culture (ie. es-us): "
  newCulture = $stdin.gets.chomp()
  if newCulture == "no"
    newCulture = ""
    p "no value"
    break
  end 
end

while newAffid.empty?
  print "New affid (ie. 1114): "
  newAffid = $stdin.gets.chomp()
  if newAffid == "no"
    newAffid = ""
    p "no value"
    break
  end 
end


# INPUT NEW CIDs
while newCid1.empty?
  print "New CID 1 (ie. 4562548): "
  newCid1 = $stdin.gets.chomp()
  if newCid1 == "no"
    newCid1 = ""
    p "no value"
    break
  end 
end

while newCid2.empty?
  print "New CID 2: "
  newCid2 = $stdin.gets.chomp()
  if newCid2 == "no"
    newCid2 = ""
    p "no value"
    break
  end 
end

while newCid3.empty?
  print "New CID 3: "
  newCid3 = $stdin.gets.chomp()
  if newCid3 == "no"
    newCid3 = ""
    p "no value"
    break
  end 
end

puts
print "New AFFID: " + newAffid + "\n\n"
print "New Culture: " + newCulture + "\n\n"


print "New CIDs: " + "\n"
if newCid1.empty? then print "1) no change\n" else puts "1) " + newCid1 end
if newCid2.empty? then print "2) no change\n" else puts "2) " + newCid2 end
if newCid3.empty? then print "3) no change\n" else puts "3) " + newCid3 end

# WHERE ALL CIDs/AFFID/CULTURE CODES ARE REPLACED
files = Dir[your_file+".html"]
files.each do |filename|
  file_content = IO.read(filename)

    if newCid1 == "" then print "no change to CID #1\n" else file_content.gsub!(oldCid1,newCid1) end
    if newCid2 == "" then print "no change to CID #2\n" else file_content.gsub!(oldCid2,newCid2) end
    if newCid3 == "" then print "no change to CID #3\n" else file_content.gsub!(oldCid3,newCid3) end
    
    if newAffid == "" then print "no change to AFFID\n" else file_content.gsub!(oldAffid,newAffid) end

    if newCulture == "" then print "no change to CULTURE\n" else file_content.gsub!(oldCulture.to_s, newCulture.to_s) end
    
    if newPrice1 == "" then print "no change to PRICE #1\n" else file_content.gsub!(oldPrice1, newPrice1) end
    if newPrice2 == "" then print "no change to PRICE #2\n" else file_content.gsub!(oldPrice2, newPrice2) end
    if newPrice3 == "" then print "no change to PRICE #3\n" else file_content.gsub!(oldPrice3, newPrice3) end

    if newStrikePrice1 == "" then print "no change to MSRP #1\n" else file_content.gsub!(strikePrice1, newStrikePrice1) end
    if newStrikePrice2 == "" then print "no change to MSRP #2\n" else file_content.gsub!(strikePrice2, newStrikePrice2) end 
    if newStrikePrice3 == "" then print "no change to MSRP #3\n" else file_content.gsub!(strikePrice3, newStrikePrice3) end

    if newSavePrice1 == "" then else file_content.gsub!(oldSavePrice1, newSavePrice1) end
    if newSavePrice2 == "" then else file_content.gsub!(oldSavePrice2, newSavePrice2) end
    if newSavePrice3 == "" then else file_content.gsub!(oldSavePrice3, newSavePrice3) end
    
    if newPercentOff == "" then else file_content.gsub!(oldPercentOff, newPercentOff) end


    

  output = File.open(filename,'w')
  output.write(file_content)
  output.close
end
exit