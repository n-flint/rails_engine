class Day
  attr_reader :id, :best_day

  def initialize(date)
    @id = 1
    @best_day = date

    # require 'pry'; binding.pry
  end
end