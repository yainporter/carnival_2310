require './spec/spec_helper'

RSpec.describe Visitor do
  it "exists" do

  expect(Visitor.new('Bruce', 54, '$10')).to be_a Visitor
  end

  it 'has @name, @height, @spending_money, and @preferences' do
    visitor1 = Visitor.new('Bruce', 54, '$10')

    expect(visitor1.name).to be_a String
    expect(visitor1.height).to be_an Integer
    expect(visitor1.spending_money).to be_an Integer
    expect(visitor1.preferences).to be_an Array
    expect(visitor1.name).to eq ("Bruce")
    expect(visitor1.height).to eq 54
    expect(visitor1.spending_money).to eq 10
    expect(visitor1.preferences).to eq []
  end

  it 'can add preferences to @preferences' do
    visitor1 = Visitor.new('Bruce', 54, '$10')

    expect(visitor1.add_preference(:gentle)).to eq [:gentle]
    expect(visitor1.add_preference(:thrilling)).to eq [:gentle, :thrilling]
    expect(visitor1.preferences).to eq [:gentle, :thrilling]
  end

  it 'has a parameter and can check check if someone is tall enough according to the parameter' do
    visitor1 = Visitor.new('Bruce', 54, '$10')
    visitor2 = Visitor.new('Tucker', 36, '$5')
    visitor3 = Visitor.new('Penny', 64, '$15')

    expect(visitor1.tall_enough?(54)).to eq(true)
    expect(visitor2.tall_enough?(54)).to eq(false)
    expect(visitor3.tall_enough?(54)).to eq(true)
    expect(visitor1.tall_enough?(64)).to eq(false)
  end
end
