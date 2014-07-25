require 'spec_helper'
require 'dddelivery'

describe Dddelivery do
  before do
    @domain = Dddelivery.new
  end

  describe "#[]" do
    expect(@domain[:product]).to be(Dddelivery::Product)
  end
end

