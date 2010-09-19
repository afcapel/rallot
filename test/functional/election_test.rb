require 'test_helper'

class RallotIntegerTest < Test::Unit::TestCase
  include Rallot
  
  test "conduct an election" do
    pubKey = PublicKey.make_partial_key(128)
  end
end