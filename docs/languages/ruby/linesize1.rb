# linesize1.rb

#
# Print all the lines of the given text file whose length if over N.
#
# Not the most efficient way, but uses some interesting Ruby features like
# ranges, zip, and select.
#

N = 80

# puts ARGV
ARGV.each do |fname|
    # puts "#{fname}"

    lines = File.readlines(fname).map {|s| s.chomp}

    #
    # The zip method returns an array of pairs:
    #
    # >> [1,2,3].zip [4,5,6]
    # => [[1, 4], [2, 5], [3, 6]]
    #
    # >> [1,2,3].zip ["red","green","yellow"]
    # => [[1, "red"], [2, "green"], [3, "yellow"]]
    #
    # The expression lines.zip(0..lines.size) returns an array of pairs, where
    # each pair contains the line of the file and its line count. This
    # information useful later for displaying which lines are too long.
    #
    # The select method returns a new array containing only the elements that
    # match the selection rule:
    #
    # >> [1,2,3,4,5].select {|n| n.even?}
    # => [2, 4]
    #
    # >> ["red","green","yellow"].select {|s| s[1] == "e"}
    # => ["red", "yellow"]
    #
    # So the entire expression returns an array of all the lines, the line and
    # its number, that are greater than N. It returns [] if no lines are too
    # long, and array of the form [["...85 chars",85], ["...102 chars",102]]
    # if there are long lines.
    #
    num_lines = lines.zip(0..lines.size).select {|p| p.first.size > N}

    if num_lines.size == 0 then
        puts "#{fname}:\n   all lines are #{N} or less"
    else
        #
        # Print the results
        #
        puts "#{fname}: "
        num_lines.each do |p|
            line = p[1] + 1
            chars = p[0].size
            prefix = p[0][...10]
            puts "   over #{N} chars on line #{line}, #{chars} chars, \"#{prefix} ...\""
        end
    end
end
