# shapes3.go

#
# Based on shapes1.rb. printShapeStats is a method in the Shape module (not
# class!), and Rectangle and Circle include Shape as a mixin.
#

module Shape
    def printShapeStats()
        puts "#{self.class.name}: area=#{area}, perimeter=#{perimeter}"
    end
end

class Rectangle
include Shape  # allows Shape methods to be called in Rectangle 

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

    def method_missing(m, *args, &block)
        puts "Shape: no method named #{m}."
    end
end

class Circle
include Shape

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

box.print
