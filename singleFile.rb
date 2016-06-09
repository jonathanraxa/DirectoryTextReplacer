#!/usr/bin/ruby

cids = Array.new(6)
oldAffid = ""
newAffid = ""
new_cids = Array.new(6)
your_file = ARGV[0]

# NEW CIDS TO REPLACE OLD ONES
newCid1 = ""
newCid2 = ""
newCid3 = ""

print "affid: "
newAffid = $stdin.gets.chomp() 

# print "CID 1: "
# newCid1 = $stdin.gets.chomp()

# print "CID 2: "
# newCid2 = $stdin.gets.chomp()

# print "CID 3: "
# newCid3 = $stdin.gets.chomp()

newCid1.to_s
newCid2.to_s
newCid3.to_s

puts "Opening file: #{your_file}"
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

puts 
puts "Current AFFID: " + oldAffid



# http://home.mcafee.com/root/campaign.aspx?culture=en-NZ&affid=1144&cid=78979
txt.scan(/culture=\d\d\d\d/) do |line|
     line.split("=")
     affid = (line[6..9])
end



file.close

# CREATE AN ARRAY OF CIDS TO BE REPLACED
# not entirely necessary but may be useful for future use
temp_cids = cids.reject { |a| a.nil? }
puts
oldCid1 = temp_cids[1]
oldCid2 = temp_cids[2]
oldCid3 = temp_cids[3]

puts 

puts "Old CIDs to be REPLACED: "
puts oldCid1
puts oldCid2
puts oldCid3

puts

puts "New CIDs: "
puts newCid1
puts newCid2
puts newCid3



# HANDLE FOR AFFID



# HANDLE FOR COUNTRY 





#WHERE ALL CIDs ARE REPLACED
files = Dir[your_file]
files.each do |filename|
  file_content = IO.read(filename)

	  # file_content.gsub!(old1,newCid1)
	  # file_content.gsub!(old2,newCid2)
	  # file_content.gsub!(old3,newCid3)
	
		file_content.gsub!(oldAffid,newAffid)

  output = File.open(filename,'w')
  output.write(file_content)
  output.close
end
exit