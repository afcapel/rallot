require 'test_helper'

class RallotIntegerTest < Test::Unit::TestCase
  include Rallot
  
  test "conduct an election" do
    puts "Election test"
    
   pub_key = PublicKey.make_partial_key_with_length(128)
    
   puts "Public Key #{pub_key.to_s}"
   
   prime = pub_key.prime
   subprime = pub_key.subprime
   generator = pub_key.generator
   message_base = pub_key.message_base
   
   num_authorities = 1
   num_choices = 10
   num_voters = 20
   
   votes = {}
   
   puts "Creating an election with #{num_authorities} authorities #{num_voters} voters and #{num_choices} choices"
   
   election = Election.new p

    puts "Authorities start"
    
    public_keys = []
    private_keys = []
    polynomials = []
    
    0.upto(num_authorities).each do
      public_key = PublicKey.new :prime => prime, :generator => generator, :message_base => message_base
      private_key = public_key.generate_private_key
      polynomial = Polynomial.new(:prime => prime, :generator => generator, :message_base => message_base, :degree => num_authorities - 1);
    end
  end
end