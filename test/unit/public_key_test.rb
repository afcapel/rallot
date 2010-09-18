require 'test_helper'

class RallotIntegerTest < Test::Unit::TestCase
  include Rallot
  
  test "Create public key from string" do
    public_key = PublicKey.from_s "p123g135h246f234"
    
    assert public_key.prime == Rallot::Integer(123)
    
    assert Rallot::Integer(135, public_key.prime) == public_key.generator
    assert Rallot::Integer(246, public_key.prime) == public_key.public_value
    assert Rallot::Integer(234, public_key.prime) == public_key.message_base
  end
end

        