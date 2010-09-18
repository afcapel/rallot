require 'test_helper'

class RallotIntegerTest < Test::Unit::TestCase
  include Rallot
  
  test "create public key from string" do
    public_key = PublicKey.from_s "p123g135h246f234"
    
    assert public_key.prime == Rallot::Integer(123)
    
    assert Rallot::Integer(135, public_key.prime) == public_key.generator
    assert Rallot::Integer(246, public_key.prime) == public_key.public_value
    assert Rallot::Integer(234, public_key.prime) == public_key.message_base
  end
  
  test "Public key to string" do
    public_key = PublicKey.new(:prime => 123, :generator => 135, :public_value => 246, :message_base => 234)
    assert public_key.to_s == "p123g135h246f234"
  end
end

        