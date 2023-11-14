class Ride
  attr_reader :name,
              :min_height,
              :admission_fee,
              :excitement,
              :total_revenue,
              :rider_log

  def initialize(hash)
    @name = hash[:name]
    @min_height = hash[:min_height]
    @admission_fee = hash[:admission_fee]
    @excitement = hash[:excitement]
    @total_revenue = 0
    @rider_log = {}
    @total_times_ridden
  end

  def board_rider(visitor)
    @total_times_ridden += 1
    @total_revenue += @admission_fee
    @rider_log.store(visitor, visitor.spend_money(@admission_fee))
  end
end
