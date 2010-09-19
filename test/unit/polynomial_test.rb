require 'test_helper'

class PolynomialTest < Test::Unit::TestCase
  include Rallot
  
  test "create from string" do
   poly = Polynomial.from_s "p123g135f246"
   assert_equal poly.prime, 123
   assert_equal poly.generator, 135
   assert_equal poly.message_base, 246
  end
end