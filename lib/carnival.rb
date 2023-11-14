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

  def summary
    summary = {}
    summary[:visitor_count] = visitor_count
    summary[:total_revenue] = total_revenue
    # summary[:visitors] =
  end

  def visitor_count
    @rides.count{|ride| ride.visitors}
  end

  # def visitors
  #   visitors = []
  #   visitor_hash = {}
  #   @rides.each do |ride|
  #     ride.rider_log.each do |visitor|
  #       visitor_hash[:visitor] = visitor
  #       visitor_hash[:favorite_ride] = visitor.
  #       visitor_hash[:total_money_spent] =
  #     end
  #   end
  # end
end
