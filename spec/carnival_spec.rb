require './spec/spec_helper'

RSpec.describe Carnival do
  it "exists" do

    expect(Carnival.new(3)).to be_a Carnival
  end

  it 'has @duration, @rides, @total_revenue' do
    carnival = Carnival.new(3)

    expect(carnival.duration).to be_an Integer
    expect(carnival.duration).to eq 3
    expect(carnival.rides).to be_an Array
    expect(carnival.rides).to eq []
  end

  describe 'rides' do
    carnival = Carnival.new(3)
    ride1 = Ride.new({ name: 'Carousel', min_height: 24, admission_fee: 1, excitement: :gentle })
    ride2 = Ride.new({ name: 'Ferris Wheel', min_height: 24, admission_fee: 2, excitement: :gentle })
    visitor1 = Visitor.new('Bruce', 54, '$10')
    visitor1.add_preference(:gentle)
    visitor2 = Visitor.new('Tucker', 36, '$5')
    visitor2.add_preference(:gentle)

    it 'can add rides' do
      expect(carnival.add_ride(ride1)).to eq [ride1]
      expect(carnival.add_ride(ride2)).to eq [ride1, ride2]
    end

    it 'can keep track of the most popular ride' do
      ride1.board_rider(visitor2)
      ride1.board_rider(visitor2)
      ride1.board_rider(visitor1)
      ride2.board_rider(visitor1)

      expect(carnival.most_popular_ride).to be_a Ride
      expect(carnival.most_popular_ride).to eq ride1
    end

    it 'can keep track of the most profitable ride' do
      expect(carnival.most_profitable_ride).to be_a Ride
      expect(carnival.most_profitable_ride).to eq ride1

      ride2.board_rider(visitor2)
      expect(carnival.most_profitable_ride).to eq ride2
    end
  end

  it 'has total_revenue tracker' do
    carnival = Carnival.new(3)

    expect(carnival.total_revenue).to be_an Integer
    expect(carnival.total_revenue).to eq 0

    ride1 = Ride.new({ name: 'Carousel', min_height: 24, admission_fee: 1, excitement: :gentle })
    ride2 = Ride.new({ name: 'Ferris Wheel', min_height: 24, admission_fee: 2, excitement: :gentle })
    visitor1 = Visitor.new('Bruce', 54, '$10')
    visitor1.add_preference(:gentle)
    visitor2 = Visitor.new('Tucker', 36, '$5')
    visitor2.add_preference(:gentle)
    carnival.add_ride(ride1)
    carnival.add_ride(ride2)
    ride1.board_rider(visitor2)
    ride1.board_rider(visitor2)
    ride1.board_rider(visitor1)
    ride2.board_rider(visitor1)

    expect(carnival.total_revenue).to eq 5
  end

  it 'can provide a summary' do
    carnival = Carnival.new(3)
    ride1 = Ride.new({ name: 'Carousel', min_height: 24, admission_fee: 1, excitement: :gentle })
    ride2 = Ride.new({ name: 'Ferris Wheel', min_height: 24, admission_fee: 2, excitement: :gentle })
    visitor1 = Visitor.new('Bruce', 54, '$10')
    visitor1.add_preference(:gentle)
    visitor2 = Visitor.new('Tucker', 36, '$5')
    visitor2.add_preference(:gentle)
    carnival.add_ride(ride1)
    carnival.add_ride(ride2)
    ride1.board_rider(visitor2)
    ride1.board_rider(visitor2)
    ride1.board_rider(visitor1)
    ride2.board_rider(visitor1)
    ride2.board_rider(visitor1)

    expected = {
      visitor_count: 2,
      revenue_earned: 7,
      visitors: [
      {
        visitor: visitor2,
        favorite_ride: ride1,
        total_money_spent: 2
      },
      {
        visitor: visitor1,
        favorite_ride: ride2,
        total_money_spent: 5
      }],
      rides: [
        {
          ride: ride1,
          riders: [visitor2, visitor1],
          total_revenue: 3
        },
        {
          ride: ride2,
          riders: [visitor1],
          total_revenue: 4
        }]
    }

    expect(carnival.summary).to be_a Hash
    expect(carnival.summary[:visitor_count]).to be_an Integer
    expect(carnival.summary[:revenue_earned]).to be_an Integer
    expect(carnival.summary[:visitors]).to be_an Array
    expect(carnival.summary[:visitors].first).to be_a Hash
    expect(carnival.summary[:visitors].first[:visitor]).to be_a Visitor
    expect(carnival.summary[:visitors].first[:favorite_ride]).to be_a Ride
    ##### CHANGE RIDE TO AN OBJECT, NOT ARRAY!!########
    expect(carnival.summary[:visitors].first[:total_money_spent]).to be_an Integer

    ####### Why doesn't this work? -- BECAISE #######
    expect(carnival.summary[:visitors].first).to eq ({
      visitor: visitor2,
      favorite_ride: ride1,
      total_money_spent: 2
    })
    expect(carnival.summary[:visitors]).to eq [
      {
        visitor: visitor2,
        favorite_ride: ride1,
        total_money_spent: 2
      },
      {
        visitor: visitor1,
        favorite_ride: ride2,
        total_money_spent: 5
      }]
    expect(carnival.summary[:rides]).to eq [
        {
          ride: ride1,
          riders: [visitor2, visitor1],
          total_revenue: 3
        },
        {
          ride: ride2,
          riders: [visitor1],
          total_revenue: 4
        }]
    expect(carnival.summary).to eq (expected)
  end

end
