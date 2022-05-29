# shapes2.rb

#
# Based on shapes1.rb. Classes inherit from the Shape base class.
# printShapeStats is a method in the Shape base class.
#

class Shape
    def printShapeStats
        puts "#{self.class.name}: area=#{area}, perimeter=#{perimeter}"
    end
end

class Rectangle < Shape
    #
    # initialize is called when a new instance of the object is created.
    # Instance variables of the class start with @.
    #
    def initialize(width, height)
        @width = width
        @height = height
    end

    def area
        @width * @height
    end

    def perimeter
        2 * (@width + @height)
    end
end

class Circle < Shape
    def initialize(radius)
        @radius = radius
    end

    def area
        3.14 * @radius ** 2
    end

    def perimeter
        2 * 3.14 * @radius
    end
end

#
# main code
#
box = Rectangle.new(4, 1)
dot = Circle.new(3)
shapes = [box, dot]

shapes.each do |s|
    s.printShapeStats
end
