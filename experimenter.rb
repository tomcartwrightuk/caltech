class Experimenter
    
  attr_accessor :results

  def initialize(run_times)
    @run_times = run_times
    @results = []
  end
    
  def run_experiment
    1.upto(@run_times).each do |i|
      puts i
      cf = CoinFlipper.new(10, 1000)
      cf.flip
      @results << [cf.first_result, cf.random_result, cf.min_result]
    end
  end

  def run_lin_regression
    e_in = 0
    e_out = 0
    1000.times do
      lr = LinearRegression.new(100)
      e_in += lr.run
      e_out += lr.e_out
    end
    puts "Average in sample error: #{e_in/1000}"
    puts "Average out of sample error: #{e_out/1000}"
  end

end
