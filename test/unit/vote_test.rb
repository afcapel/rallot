require 'test_helper'

class RallotIntegerTest < Test::Unit::TestCase
  include Rallot
  
  test "create a vote from a string" do
    vote = Vote.from_s "p123G135H246"
    
    first_cipher = vote.cipher_list.first
    prime = first_cipher.prime.value
     
    assert Rallot::Integer(123) == first_cipher.prime
    assert Rallot::Integer(:value => 135, :modulus => prime) == first_cipher.generator
    assert Rallot::Integer(:value => 246, :modulus => prime) == first_cipher.public_value
  end
  
end