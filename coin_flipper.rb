class CoinFlipper

  attr_accessor :flips  
  
  def initialize(flip_count, coin_count)
    @flips = []
    @coin_count = coin_count
    @flip_count = flip_count
    @random_machine = Random.new
  end
    
  def flip
    @coin_count.times do
      local_flips = []
      @flip_count.times do
        local_flips << @random_machine.rand(0..1) 
        @flips << local_flips
      end
    end
  end

  def coin_flip_result(coin_number)
    if @flips.length > 0
      @flips[coin_number-1]
    else
      puts "Flip the coint first"
    end
  end 

  def first_result
    av_first_result = @flips[0].inject(:+).to_f / @flip_count
    av_first_result.nan? ? 0 : av_first_result
  end

  def random_result
    av_rand_result  = @flips[@random_machine.rand(0..@coin_count)].inject(:+).to_f / @flip_count
    av_rand_result.nan? ? 0 : av_rand_result
  end

  def min_result
    reduced_results = @flips.map{ |e| e.inject(:+) }
    reduced_results.min.to_f.nan? ? 0 : reduced_results.min.to_f / @flip_count
  end
end
