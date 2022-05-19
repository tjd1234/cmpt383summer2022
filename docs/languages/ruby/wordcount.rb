# wordcount.rb

#
# Count the number of words in a file, and print a list of the top N most
# frequently occurring words. You can print the top N=10 words by default, but
# it should work with any value of N.
#
# For words with same count, sort them by alphabetical order in the list.
#
# Convert all uppercase letters A-Z to lowercase a-z, and replace characters
# that are not a-z with spaces.
#

#
# Create a list of all words in a file.
#
# The file is read as one big string that is first converted to lower case
# using downcase.
# 
# [^a-z] is a regular expression that matches all characters that are *not*
# one of the 26 lowercase letters a-z. Each of those matching characters is
# replaced by a space.
#
# For example:
#
#    "  apple, pear, cherry!!".gsub(/[^a-z]/, ' ')
#    => "  apple  pear  cherry  "
#
# split chops a string into individual words, using spaces as separators. For
# example:
#
#    > "  apple  pear  cherry  ".split
#    => ["apple", "pear", "cherry"]
#
# Altogether, this reads a text file into a list of words consisting of just
# the letters a-z.
#
fname = "austenPandP.txt"
words = File.open(fname).read.downcase.gsub(/[^a-z]/, ' ').split

#
# Create a hash table of (word, count) pairs.
#
# Ruby hash tables begin with { and end with }.
# They consist of key/value pairs, e.g.:
#
#    > fruit = {"pear" => 1, "apple" => 2, "cherry" => 3}
#    > fruit["orange"]
#    => nil
#    > fruit["cherry"]
#    => 3
#
# This codes creates an initially empty hash table, and then adds each words
# from words to it.
#
wc = {}
words.each do |w| 
	if wc.has_key?(w)
		wc[w] += 1
	else
		wc[w] = 1
	end
end

# puts wc

# Sort the pairs first alphabetically by word, and then from highest count to
# lowest count.
sorted_pairs = wc.sort_by {|w,c| w} .sort_by {|w,c| -c }

# Display the list of sorted words and their counts.
puts "Top 10 Most Frequent Words in #{fname}"
sorted_pairs[0..9].each_with_index do |p,i|
	puts "#{i+1}. #{p[0]} (#{p[1]})"
end
