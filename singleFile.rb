#!/usr/bin/ruby

cids = Array.new(6)
new_cids = Array.new(6)
your_file = ARGV[0]

# NEW CIDS TO REPLACE OLD ONES
new1 = ""
new2 = ""
new3 = ""

print "CID 1: "
new1 = $stdin.gets.chomp()

print "CID 2: "
new2 = $stdin.gets.chomp()

print "CID 3: "
new3 = $stdin.gets.chomp()

new1.to_s
new2.to_s
new3.to_s

puts "Opening file: #{your_file}"
file = File.open(your_file)

txt = file.read()

# SPLITS CID AT "=" AND PUSHES NUMBER TO ARRAY
txt.scan(/cid=\d\d\d\d\d\d/) do |line|
    line.split("=")
    cids.push(line[4..9])
end

file.close

# CREATE AN ARRAY OF CIDS TO BE REPLACED
temp_cids = cids.reject { |a| a.nil? }

puts 

old1 = temp_cids[1]
old2 = temp_cids[2]
old3 = temp_cids[3]

puts 

puts "Old CIDs to be REPLACED: "
puts old1
puts old2
puts old3

puts

puts "New CIDs: "
puts new1
puts new2
puts new3

# WHERE ALL CIDs ARE REPLACED
files = Dir[your_file]
files.each do |filename|
  file_content = IO.read(filename)

	  file_content.gsub!(old1,new1)
	  file_content.gsub!(old2,new2)
	  file_content.gsub!(old3,new3)


  output = File.open(filename,'w')
  output.write(file_content)
  output.close
end
exit