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
    @rides.max_by{|ride| ride.total_revenue/ride.admission_fee}
  end

  def most_profitable_ride
    @rides.max_by{|ride| ride.total_revenue}
  end

  def total_revenue
    @rides.sum{|ride| ride.total_revenue}
  end

  def summary
    {
      visitor_count: visitor_count,
      revenue_earned: total_revenue,
      visitors: visitors_array,
      rides: rides_array
    }
  end

  def visitor_count
    @rides.count{|ride| ride.rider_log.keys}
  end

  def visitors_array
    visitors = []
    @rides.each do |ride|
        ride.rider_log.keys.each do |visitor|
          visitor_hash = {}
          visitor_hash[:visitor] = visitor
          visitor_hash[:favorite_ride] = favorite_ride(visitor)
          visitor_hash[:total_money_spent] = visitor.money_spent
          visitors << visitor_hash
        end
        break
    end
    visitors
  end

  def favorite_ride(visitor)
    @rides.select{|ride| ride.name.include?(visitor.favorite_ride)}.pop
  end

  def rides_array_hash
    rides = []
    @rides.each do |ride|
      rides_hash = {}
      rides_hash[:ride] = ride
      rides_hash[:riders] = ride.rider_log.keys
      rides_hash[:total_revenue] = ride.total_revenue
      rides << rides_hash
    end
    rides
  end
end
