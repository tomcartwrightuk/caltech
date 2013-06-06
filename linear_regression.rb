class LinearRegression

  require 'matrix'

  attr_accessor :data, :target, :evaluated_data, :lin_data, :incorrect_fraction, :e_out

  def initialize(n_size)
    @n_size = n_size 
    @data = []
    @target = []
    @mean_of_x = 0
    @mean_of_y = 0
    @slope = 0
    @y_intecept = 0
    @e_out = 0
  end

  def run
    generate_data
    generate_target
    @evaluated_data = evaluate_target(@data)
    @x_mean = mean_values(@data, 0)
    @y_mean = mean_values(@data, 1)
    @lin_data = evaluate_lin_func(@data)
    find_error(@evaluated_data, @lin_data)
  end

  def generate_data
    r = Random.new
    @n_size.times do
      x = r.rand(-1.0..1.0).round(4)
      y = r.rand(-1.0..1.0).round(4)
      @data << Vector[x, y]
    end
  end

  def generate_target
    r = Random.new
    x1 = r.rand(-1.0..1.0).round(4)
    x2 = r.rand(-1.0..1.0).round(4)
    @target = [Vector[x1, 1], Vector[x2, -1]]
  end

  def evaluate_target(data)
    data.map{ |v|
      sign = ((@target[1][0] - @target[0][0]) * (v[1] - @target[0][1])) - ((@target[1][1] - @target[0][1]) * (v[0] - @target[0][0]))
      v = [v, sign < 0 ? 0 : 1]
    }
  end

  def mean_values(values, axis)
    total = values.map{ |e| e[axis]}.reduce(0) { |sum, x| x + sum }
    inst_var = Float(total) / Float(values.length)
  end

  def slope
    xs = @data.map{ |v| v[0] }
    ys = @data.map{ |v| v[1] }
    numerator = (0...xs.length).reduce(0) do |sum, i|
      sum + ((xs[i] - @x_mean) * (ys[i] - @y_mean))
    end
    
    denominator = xs.reduce(0) do |sum, x|
      sum + ((x - @x_mean) ** 2)
    end

    (numerator / denominator)
  
  end

  def y_intercept
    @y_mean - (slope * @x_mean)
  end
  
  def evaluate_lin_func(data)
    lin_data = []
    data.each do |v|
      y_at_line = slope * v[0] + y_intercept
      lin_data << [v, y_at_line < v[1] ? 1 : 0]
    end
    lin_data
  end

  def find_error(target_data, lin_func_data)
    incorrect_fraction = 0
    target_data.each_with_index do |e, i|
      if lin_func_data[i][1] != e[1]
        incorrect_fraction += 1
      end
    end
    return incorrect_fraction.to_f/target_data.length
  end

  def find_e_out
    out_sample_data = []
    r = Random.new
    1000.times do
      x = r.rand(-1.0..1.0).round(4)
      y = r.rand(-1.0..1.0).round(4)
      out_sample_data << Vector[x, y]
    end
    evaluated_out_sample = evaluate_target(out_sample_data)
    evaluated_lin_out = evaluate_lin_func(out_sample_data)
    @e_out = find_error(evaluated_out_sample, evaluated_lin_out)
  end
      

  def self.reload
    load '~/ml/linear_regression.rb'
  end
end
