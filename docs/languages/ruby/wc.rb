# wordcount.rb

#
# A simple Ruby word counting program that mimics the basic behaviour of the
# standard wc word counting program.
#
# The main goal here is to write a relatively simple program in a short amount
# of time. The speed of the program is not a major design goal.
# 
# For example:
#
#    $ ruby wc.rb *.txt
#    13427 124580 704158 austenPandP.txt
#    5 6 21 numbers.txt
#    2 16 73 short.txt
#    13434 124602 704252 total
#
#    $ wc *.txt
#     13427 124580 704158 austenPandP.txt
#         5      6     21 numbers.txt
#         2     16     73 short.txt
#     13434 124602 704252 total
#

#
# ARGV is a pre-defined Ruby array that contains the command line arguments
# passed to the program.
#
if ARGV.size == 0 then
	puts "No file names given.\nCall with at least one text file name."
	return
end

#
# If multiple files are given we want to print the total counts.
#
total_lines = 0
total_words = 0
total_chars = 0

#
# Count each of the passed in files.
#
ARGV.each do |fname|
	s = File.read(fname) 	# read the file as a big string

	num_chars = s.size
	num_lines = s.count "\n"
	num_words = s.split.size

	puts "#{num_lines} #{num_words} #{num_chars} #{fname}"

	total_lines += num_lines
	total_words += num_words
	total_chars += num_chars
end

puts "#{total_lines} #{total_words} #{total_chars} total" if ARGV.size > 1
