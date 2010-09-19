require 'test_helper'

class PrivateKeyTest < Test::Unit::TestCase
  include Rallot
  
  test "create a private key from a string" do
    private_key = PrivateKey.from_s "p123g135x246f234"
    assert_equal 123, private_key.prime
    assert_equal Rallot::Integer(135, 123), private_key.generator
    assert_equal Rallot::Integer(246, private_key.subprime.to_i), private_key.random
    assert_equal Rallot::Integer(234, 123), private_key.message_base
  end
end