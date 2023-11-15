class Visitor
  attr_reader :name,
              :height,
              :spending_money,
              :preferences,
              :ride_tracker,
              :money_spent

  def initialize(name, height, spending_money)
    @name = name
    @height = height
    @spending_money = spending_money.delete('$').to_i
    @preferences = []
    @ride_tracker = Hash.new(0)
    @money_spent = 0
  end

  def add_preference(preference)
    @preferences << preference if !@preferences.include?(preference)
  end

  def tall_enough?(height)
    @height >= height
  end

  def spend_money(cost)
    @money_spent += cost
    @spending_money -= cost

  end

  def track_ride(ride)
    @ride_tracker[ride] += 1
  end

  def favorite_ride
    @ride_tracker.max.shift
  end

end
