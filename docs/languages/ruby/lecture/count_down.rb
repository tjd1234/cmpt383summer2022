# count_down.rb

puts 'Launch in '
10.downto(1) {|i| puts "... #{i}"}
puts 'Blast off!'

puts '-' * 25

# Alternate notation using do/begin.
puts 'Launch in '
10.downto(1) do |i| 
	puts "... #{i}"
end
puts 'Blast off!'