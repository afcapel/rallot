require 'test_helper'

class RallotIntegerTest < Test::Unit::TestCase
  include Rallot
  
  test "create a vote from a string" do
    vote = Vote.from_s "p123G135H246"
    
    first_cipher = vote.cypherlist.first
    prime = first_cipher.prime.value
     
    assert Rallot::Integer(123) == first_cipher.prime
    assert Rallot::Integer(:value => 135, :modulus => prime) == first_cipher.generator
    assert Rallot::Integer(:value => 246, :modulus => prime) == first_cipher.public_value
  end
  
  test "create vote from cyphertexts" do
    cyphertext = ElGammalCypherText.new(:generator => 135, :public_value => 246, :private_value => 111, :prime => 123) 
    
    vote = Rallot::Vote.new([cyphertext])
    
    assert vote.cypherlist[0].prime == Rallot::Integer(123) # 123 
    assert vote.cypherlist[0].generator == Rallot::Integer(:value => 135, :modulus => 123)
    assert vote.cypherlist[0].public_value == Rallot::Integer(:value => 246, :modulus => 123)
    assert vote.cypherlist[0].private_value == Rallot::Integer(111)
    
    assert vote.cypherlist[0].to_s == "p123G12H0"
    assert vote.cypherlist[0].short_hash == "3b589"
  end
  
  test "inavlid votes raises exceptions" do
    
    assert_raise InvalidVoteException do
      Vote.from_s "p123G123"
    end
    
    assert_raise InvalidVoteException do
      Vote.from_s "qGH"
    end
    
    assert_raise InvalidVoteException do
      Vote.from_s "p123H123H123"
    end
    
    assert_raise InvalidVoteException do
      Vote.from_s "p123G123G123"
    end
    
    assert_raise InvalidVoteException do
      Vote.from_s "p123G123H12a"
    end
    
    assert_raise InvalidVoteException do
      Vote.from_s "p123G123H123p123"
    end
  end
  
  test "raises exception when vote proof is wrong" do
    # TODO
  end
  
end