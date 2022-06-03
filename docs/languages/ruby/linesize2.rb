# linesize2.rb

#
# Print all the lines of the given text file whose length if over N.
#
# Much simpler and more efficient than linesize1.rb. The output format is
# different.
#

N = 80

ARGV.each do |fname|
    line_num = 0
    any_long = false
    print "#{fname}: "
    File.readlines(fname).each do |line|
        line_num += 1
        if line.size > N then
            any_long = true
            nc = line.size
            firstN = line[...10]
            print "\n   over #{N} chars on line #{line_num}, #{nc} chars, \"#{firstN} ...\""
        end
    end
    puts "no long lines" if not any_long
end
