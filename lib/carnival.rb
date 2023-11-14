class Carnival
  attr_reader :duration,
              :rides,
              :total_revenue

  def initialize(duration)
    @duration = duration
    @rides = []
  end

  def add_ride(ride)
    @rides << ride
  end

  def most_popular_ride
    @rides.max_by{|ride| ride.total_times_ridden}
  end

  def most_profitable_ride
    @rides.max_by{|ride| ride.total_revenue}
  end

  def total_revenue
    total_revenue = 0
    @rides.each do |ride|
      total_revenue += ride.total_revenue
    end
    total_revenue
  end
end
