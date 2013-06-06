class Perceptron

  attr_accessor :data

  def initialize(target_function = TargetFunction.new)
    @target_function = target_function
    puts @target_function
    @data = generate_data
    @iterations = 0
  end

  def generate_data
    data = []
    200.times do
      data << Point.new(@target_function)
    end
    puts "generated data"
    return data
  end
  
  def learn_loop(function = LearningFunction.new)
    updated_function = function
    while updated_function 
       puts "Bias: #{updated_function.bias}"
       puts "Coffx: #{updated_function.coffx}"
       puts "Coffy: #{updated_function.coffy}"
       updated_function = learn(updated_function)
    end
  end

  def learn(function)
    misclassified_points = function.compare(@data)
    puts "Misclassied length: #{misclassified_points.length}"
    misclassified_point = misclassified_points[0]
    unless misclassified_point
      puts "Done"
      puts "Took #{@iterations} interations"
      return nil
    end
    @iterations += 1
    updated_function = function.update(misclassified_point) 
  end

end

class TargetFunction
  
  attr_accessor :bias, :coffx, :coffy

  def initialize
    @bias, @coffx, @coffy = RandGen.generate, RandGen.generate, RandGen.generate
  end

end    

class LearningFunction
  
  attr_accessor :bias, :coffx, :coffy
  def initialize
    @bias, @coffx, @coffy = 0, 0, 0
  end

  def update(point)
    binding.pry if point.is_a?(Array)
    uB = point.classification
    uX = point.x * uB
    uY = point.y * uB
    @bias += uB
    @coffx += uX
    @coffy += uY
    return self
  end

  def compare(data)
    misclassifieds = []
    data.each do |point|
      new_classification = point.classify_point(self)
      if new_classification != point.classification
        misclassifieds << point
      end
    end
    return misclassifieds
  end 

end

class RandGen
  def self.generate
    r = Random.new
    r.rand(-1.0..1.0).round(8)
  end
end

class Point
  
  attr_accessor :classification, :y, :x
  def initialize(target_function)
    @x = RandGen.generate
    @y = RandGen.generate
    @classification = classify_point(target_function)
  end
  
  def point
    [@x, @y, @classification]
  end

  def classify_point(function)
    n = function.bias + function.coffx * self.x + function.coffy * self.y 
    n >= 0 ? 1 : -1
  end

end
