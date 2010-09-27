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
      public_keys  << public_key
      private_keys << public_key.generate_private_key
      polynomials  << Polynomial.new(:prime => prime, :generator => generator, :message_base => message_base, :degree => num_authorities - 1);
    end
    
    poly_map = {}
    
    # # TODO: shared public key creation algorithm
    # 
    # puts "Public final key created"
    # 
    # puts "Authorities end"
    #     
    # puts "Voters begin"
    # 
    # 0.upto(num_voters).each do |i|
    #   choice = RallotInteger.random(:max => num_choices).to_i
    #   
    #   puts "Voter #{i+1}  attempting to cast vote for #{choice}"
    #   
    #   choices = []
    #   0.upto(num_choices).each do |c| 
    #     choices << choice == c ? Rallot::Integer(1) : Rallot::Integer(0) # 1 for the voter choice
    #   end
    #   
    #   puts "Encrypting vote"
    #   
    #   # TODO
    #   
    #   puts "Prooving vote"
    #   # TODO
    #   
    #   puts "Verifying vote"
    #   
    #   puts "Casting vote"
    # end
  end
end