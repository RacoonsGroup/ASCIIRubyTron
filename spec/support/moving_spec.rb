require "spec_helper"

describe Moving do
  describe '.get_head_coordinates' do
    it "returns coordinates of first element" do
      Moving.stub(:snake).and_return(['1,1', '2,2', '3,3'])
      expect(Moving.get_head_coordinates).to eq ['1','1']
    end
  end
end
