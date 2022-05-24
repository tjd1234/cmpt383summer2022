# hello_name.rb

print "What's your name? "

# chomp removes any trailing '\n' or '\r\n'
name = gets.chomp   # no need to put () after chomp

# #{}-notation lets you put Ruby code inside strings
puts "Hi #{name.capitalize}, how are you?"
