# hello_name.rb

print "What's your name? "

# chomp removes any trailing '\n' or '\r\n'
name = gets.chomp   # no need to put () after chomp

# #{} notation lets us put Ruby code inside strings
print "Hi #{name.capitalize}, how are you?\n"
