require './spec/spec_helper'

RSpec.describe Ride do
  it "exists" do
    expect(Ride.new({ name: 'Carousel', min_height: 24, admission_fee: 1, excitement: :gentle })).to be_a Ride
  end

  it 'has one parameter with @name, @min_height, @admission_fee, @excitement, @total_revenue and @rider_log' do
    ride1 = Ride.new({ name: 'Carousel', min_height: 24, admission_fee: 1, excitement: :gentle })

    expect(ride1.name).to be_a String
    expect(ride1.min_height).to be_an Integer
    expect(ride1.admission_fee).to be_an Integer
    expect(ride1.excitement).to be_a Symbol
    expect(ride1.total_revenue).to be_an Integer
    expect(ride1.rider_log).to be_a Hash
    expect(ride1.name).to eq("Carousel")
    expect(ride1.min_height).to eq 24
    expect(ride1.admission_fee).to eq 1
    expect(ride1.excitement).to eq (:gentle)
    expect(ride1.total_revenue).to eq 0
    expect(ride1.rider_log).to eq ({})

  end

  describe 'can let Visitors ride the rides' do
    ride1 = Ride.new({ name: 'Carousel', min_height: 24, admission_fee: 1, excitement: :gentle })
    visitor1 = Visitor.new('Bruce', 54, '$10')
    visitor1.add_preference(:gentle)
    visitor2 = Visitor.new('Tucker', 36, '$5')
    visitor2.add_preference(:gentle)

    it 'can board_rider and keep track of how much money they made off the Visitor' do
      expect(ride1.board_rider(visitor1)).to be_an Integer
      expect(ride1.board_rider(visitor2)).to eq 4
      expect(ride1.board_rider(visitor1)).to eq 8

    end

    it 'adds them to @rider_log' do
      expect(ride1.rider_log).to eq ({visitor1 => 2, visitor2 => 1})
    end

    it 'can take a Visitors spending money for the ride' do
      expect(visitor1.spending_money).to eq 8
      expect(visitor2.spending_money).to eq 4
    end

    it 'can add to the total revenue after Visitors ride' do
      expect(ride1.total_revenue).to eq 3
    end

    it 'can keep track of the number of times the Visitors have ridden' do
      expect(ride1.total_times_ridden).to be_an Integer
      expect(ride1.total_times_ridden).to eq 3

      ride1.board_rider(visitor2)

      expect(ride1.total_times_ridden).to eq 4
    end
  end
end
