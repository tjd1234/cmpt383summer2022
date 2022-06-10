# shapes1.rb

#
# Creates Rectangle and Circle class with no inheritance. printShapeStats is
# an ordinary function.
#

class Rectangle
    #
    # This lines creates "getter" methods for the width and height variables.
    #
    attr_reader :width, :height

    #
    # initialize is called when a new instance of the object is created. The
    # instance variables of the class start with @.
    #
    def initialize(width, height)
        raise "Rectangle: width must be > 0" if width <= 0
        raise "Rectangle: height must be > 0" if height <= 0
        @width = width
        @height = height
    end

    def area             # no need to write brackets for no-input methods
        @width * @height # last line of a method/function is implicit return
    end

    def perimeter
        2 * (@width + @height)
    end

    def diagonal
        Math.sqrt(@width**2 + @height**2)
    end

    #
    # to_s is the standard Ruby method for returning a string representation
    #
    def to_s
        "Rectangle(w=#{@width}, h=#{@height})"
    end
end

class Circle
    #
    # This lines creates a "getter" method for the radius variable.
    #
    attr_reader :radius

    #
    # initialize is called when a new instance of the object is created. The
    # instance variables of the class start with @.
    #
    def initialize(radius)
        raise "Circle: radius must be > 0" if radius <= 0
        @radius = radius
    end

    def area
        3.14 * @radius ** 2
    end

    def perimeter
        2 * 3.14 * @radius
    end

    #
    # diagonal line through circle's center is the circle's diameter
    #
    def diagonal
        2 * @radius
    end

    #
    # to_s is the standard Ruby method for returning a string representation
    #
    def to_s
        "Circle(r=#{@radius})"
    end
end

# duck typing
def printShapeStats(s)
    begin
        puts s
        puts "#{s.class.name}: #{s.area}, #{s.perimeter}, #{s.diagonal}"
    rescue NoMethodError
        puts "printShapeStats: #{s.class.name} is missing a method!"
    end
end

#
# main code
#
box = Rectangle.new(4, 1)
puts "box.width = #{box.width}, box.height = #{box.height}"

dot = Circle.new(3)
puts "dot.radius = #{dot.radius}"

shapes = [box, dot]

shapes.each do |s|
    printShapeStats(s)
end

# What happens when you pass an object with area or perimeter methods?
printShapeStats("triangle")
