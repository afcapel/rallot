module Rallot
  #
  # Represents a vote an optionally, the proof
  #
  class ElGammalCypherText
    attr_reader :generator    # g in Adder
    attr_reader :public_value # h in Adder
    attr_reader :random_value # r in Adder
    attr_reader :prime        # p in Adder

    attr_accessor :membership_proof

    def initialize(attrs = {})
      @prime = Rallot::Integer(attrs[:prime])
      @generator = Rallot::Integer(:value => attrs[:generator], :modulus => attrs[:prime])
      @public_value = Rallot::Integer(:value => attrs[:public_value], :modulus => attrs[:prime])
      
      if attrs[:random_value]
         @private_value = Rallot::Integer(attrs[:random_value])
      else
        @private_value = Rallot::Integer(0)
      end
    end
    
    #
    # Returns the short hash of this vote, ignoring the ballot proof.
    #
    def short_hash
      # TODO
    end
    
    def *(other)
      p = self.prime
      g = self.generator * other.generator
      h = self.public_value * other.public_value
      r = self.random_value + other.random_value
      
      return ElGammalCypherText.new(:prime => p, :generator => g, :public_value => h, :random_value => r);
    end
    
    #
    # Creates a ElgamalCiphertext from the string standard representation as
    # described in the to_s method.
    #
    def self.from_s(s)
      match = /p(\d+)G(\d+)H(\d+)(\s(.*))?/.match(s)
      
      # GMP should accept strings to initialize integers, but this doesn't seems to
      # work on my computer (Mac Os X 32 bit), so we'll transform them to integers first
      
      p = match[1].to_i
      g = match[2].to_i
      h = match[3].to_i
      
      ElGammalCypherText.new(:generator => g, :prime => p, :public_value => h)
    end
    
    #
    # Returns a string object representing this ElgamalCiphertext
    #
    def self.to_s
      des = "p#{self.prime}G#{self.generator}H#{self.public_value}"
      
      if (self.membership_proof)
        des += " #{self.membership_proof.to_s}"
      end
      
      return des
    end
      
      
  end
end
