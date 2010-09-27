require 'test_helper'

class RallotIntegerTest < Test::Unit::TestCase
  include Rallot
  
  test "creation with integers" do
    assert Integer(5, 7).value == 5
    assert Integer(5, 7).modulus == 7
    
    assert Integer(5).value == 5
    assert Integer(5).modulus == 0
  end
  
  test "creation with strings" do
    assert Integer("5", "7").value == 5
    assert Integer("5", "7").modulus == 7
    
    assert Integer("5").value == 5
    assert Integer("5").modulus == 0
  end
  
  test "equality" do
    five = Integer(:value => 5, :modulus => 7)
    other_five = Rallot::Integer(:value => 5, :modulus => 7)
    
    assert five == other_five
    assert other_five == five
    
    six = Integer(:value => 6, :modulus => 7)
    assert five != six
    assert six  != five
    
    assert six == 6
    assert five == 5
    
    assert Integer(:value => 5, :modulus => 3) == 2
  end
  
  test "comparison " do
    assert Integer(:value => 6, :modulus => 7) > Integer(:value => 5, :modulus => 7)
    assert Integer(:value => 6, :modulus => 7) > Integer(:value => 5, :modulus => 7)
    assert Integer(:value => 8, :modulus => 7) < Integer(:value => 5, :modulus => 7)
  end
  
  test "addition" do
    five_modulus_seven = Integer(:value => 5, :modulus => 7)
    sum = five_modulus_seven + 10
    assert sum.value == 1
    assert sum.modulus == 7
     
    five_plus_eight = five_modulus_seven + 8
    assert five_plus_eight.value == 6
    assert five_modulus_seven + 8 == 6
  end
  
  test "multiplication" do
    five = Integer(:value => 5, :modulus => 7)
    
    assert five * 4 == 6 # 20 mod 7
    assert five * Integer(:value => 4, :modulus => 7) == 6
    assert five * Integer(:value => 4, :modulus => 8) == 6
    assert five * Integer(:value => 4, :modulus => 3) == 5
  end
  
  test "power" do
    seven = Integer(7)
    
    assert seven.pow(2) == 49
    assert RallotInteger === seven.pow(2), "The power of a RallotInteger must be another RallotInteger"
  end
  
  test "create random with max length" do
    random = RallotInteger.random(:max_length => 64)
    
    assert RallotInteger === random
    assert random > 0
    assert random < (2**64) -1
  end
  
  test "create random with max value" do
    random = RallotInteger.random(:max => 128)
    
    assert RallotInteger === random
    assert random > 0
    assert random < 128
  end
  
  # test "coercion" do
  #     five_modulus_seven = Integer(:value => 5, :modulus => 7)
  #     assert (2 + five_modulus_seven) === RallotInteger
  #   end
    
end