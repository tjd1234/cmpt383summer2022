# phoneNumCheck.rb

#
# Uses regular expressions to check for various different phone number
# formats.
#

# \( \) \. are used for matching literal strings "(" ")" "."
formats = [/^(\d\d\d )?\d\d\d \d\d\d\d$/,       # 778 782 3111
           /^(\d\d\d-)?\d\d\d-\d\d\d\d$/,       # 778-782-3111
           /^(\d\d\d\.)?\d\d\d\.\d\d\d\d$/,     # 778.782.3111
           /^(\d\d\d)?\d\d\d\d\d\d\d$/,         # 7787823111
           /^(\(\d\d\d\) )?\d\d\d \d\d\d\d$/,   # (778) 782 3111
           /^(\(\d\d\d\)-)?\d\d\d-\d\d\d\d$/,   # (778)-782-3111
           /^(\(\d\d\d\)\.)?\d\d\d\.\d\d\d\d$/  # (778).782.3111
]

goodNums = ["778 782 3111"  , "778-782-3111"  , "778.782.3111"  ,
            "782 3111"      , "782-3111"      , "782.3111"      ,
            "(778) 782 3111", "(778)-782-3111", "(778).782.3111",
            "782 3111"      , "782-3111"      , "782.3111"      ,
           ]

badNums = ["78 782 3111"    , "778782-3111"  , "778-782.3111"  ,
           "(782 3111"      , "782 - 3111"   , "782. 3111"     ,
           "(778)  782 3111", "(778)782-3111", "(778) 782.3111",
           "782 311 1"      , "78 2-3111"    , "78231111"      ,
          ]


goodNums.each do |phn|
    puts "no match: #{phn}" if formats.all? {|regex| (phn =~ regex) == nil }
end
puts "... good numbers checked"

badNums.each do |phn|
    formats.each do |regex|
        m = phn =~ regex 
        if m != nil then
            puts "bad match: #{phn} =~ #{regex} is #{m}"
        end
    end
end
puts "... bad numbers checked"
