require File.expand_path('../../spec_helper', __FILE__)

describe Enumerable, "#concating" do

  it "returns the same collection as concat" do
    as = [1,2,3]
    bs = [4,5,6]
    (as.concating bs).to_a.should == as.concat(bs)
  end

  it "processes items on demand" do
    as = [1,2].mapping {|i| i}
    bs = [3,4].mapping {|i| raise 'boom' if i == 4; i}
    (as.concating bs).first(3).should == [1,2,3]
  end

  it "works with multi arguments blocks" do
    as = [1,2,3]
    bs = [4,5,6]
    (as.each_with_index.concating bs.each_with_index).to_a.should == as.each_with_index.to_a.concat(bs.each_with_index.to_a)
  end

  it "works on an empty array" do
    [].concating([1,2]).to_a.should == [1,2]
  end
end

describe Enumerable, '#flattening' do

  it "returns the same collection as flatten" do
    tree = [[1], [1,2], [1,[2,3]]]
    tree.flattening.to_a.should == tree.flatten
    tree.flattening(1).to_a.should == tree.flatten(1)
  end

  it "processes items on demand" do
    processed_items = 0
    enums = (1..3).mapping {|i| (1..i).mapping {|j| processed_items += 1; j}}

    enums.flattening.first(3).should == [1, 1,2]
    processed_items.should == 3
  end

  it "returns empty list for empty list" do
    [].flattening.to_a.should == []
  end
end
