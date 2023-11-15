class Ride
  attr_reader :name,
              :min_height,
              :admission_fee,
              :excitement,
              :total_revenue,
              :rider_log,
              :total_times_ridden

  def initialize(hash)
    @name = hash[:name]
    @min_height = hash[:min_height]
    @admission_fee = hash[:admission_fee]
    @excitement = hash[:excitement]
    @total_revenue = 0
    @rider_log = Hash.new(0)
  end

  def board_rider(visitor)
    if visitor.preferences.include?(@excitement) && visitor.height >= @min_height && visitor.spending_money >= @admission_fee - visitor.spending_money
      @total_revenue += @admission_fee
      @rider_log.store(visitor, visitor.track_ride(@name))
      visitor.spend_money(@admission_fee)
    else
      "ERROR"
    end
  end
end
