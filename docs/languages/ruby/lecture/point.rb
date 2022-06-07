# point.md

# represents (x, y)
class Point1
	# constructor
	def initialize(x, y)
		@x = x
		@y = y
	end

	def get_x    # getter
		@x
	end

	def set_x(x) # setter
		@x = x
	end

	def get_y    # getter
		@y
	end

	def set_y(y) # setter
		@y = y
	end

	def to_s
		"(#{@x}, #{@y})"
	end

end # Point1


# represents (x, y)
class Point2
	attr_accessor :x, :y

	# constructor
	def initialize(x, y)
		@x = x
		@y = y
	end

	def to_s
		"(#{@x}, #{@y})"
	end

	def +(other)
		Point2.new(@x + other.x, @y + other.y)
	end
end # Point2


class NamedPoint < Point2
    attr_accessor :name

    def initialize(name, x, y)
        super(x, y)
        @name = name
    end

    def to_s
        @name + super.to_s
    end
end # NamedPoint






# prints string representation of an object to a file
module ToFile
    def filename
        "object_#{self.object_id}.txt"
    end

    def to_f
        File.open(filename, 'w') {|f| f.write(to_s)}
    end
end

class NamedPoint2 < Point2
    include ToFile  # mix-in

    attr_accessor :name

    def initialize(name, x, y)
        super(x, y)
        @name = name
    end

    def to_s
        @name + super.to_s
    end
end # NamedPoint2




class NamedPoint3 < Point2
    include ToFile
    include Comparable  # requires <=> operator
    include Enumerable  # requires each method

    attr_accessor :name

    def initialize(name, x, y)
        super(x, y)
        @name = name
    end

    def to_s
        "#{@name}(#{@x}, #{@y})"
        # @name + super.to_s
    end

    #
    # <=> is the "spaceship" operator, and a <=> b returns the following:
    # -  0 if a and b are the same
    # - -1 if a comes strictly before b
    # -  1 if a comes strictly after b
    #
    # For example:
    #
    # >> 3 <=> 3
    # => 0
    # >> 3 <=> 4
    # => -1
    # >> 3 <=> 2
    # => 1
    #
    # If a class implements <=>, then it can include the Comparable module and
    # get all the methods defined there:
    # https://docs.ruby-lang.org/en/2.5.0/Comparable.html
    #
    def <=>(b)
        [@x, @y] <=> [b.x, b.y]
        #
        # An alternative implementation:
        # return -1 if @x < b.x
        # return 1 if @x > b.x
        #
        # # at this point @x == b.x
        # return 0 if @y == b.y
        # return -1 if @y < b.y
        # return 1 if @y > b.y
    end

    #
    # By providing an implementation of each, all the methods defined in in
    # the Enumerable module work with NamedPoint3. It's as if a NamedPoint3
    # object is an array of 2 elements, x and y.
    #
    def each
        yield @x
        yield @y
    end
end # NamedPoint3

