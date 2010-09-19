module Rallot
  class InvalidPrivateKeyException < StandardError; end
  
  class PrivateKey
    attr_reader :prime        # P in Adder
    attr_reader :subprime    # Q in Adder
    attr_reader :generator    # G in Adder
    attr_reader :random       # X in Adder
    attr_reader :message_base # F in Adder
    
    def initialize(attrs)
      @prime = Rallot::Integer attrs[:prime]
      @generator = Rallot::Integer(:value => attrs[:generator], :modulus => @prime)
      @subprime = Rallot::Integer attrs[:subprime] || (@prime-1)/2
      @random = Rallot::Integer(:value => attrs[:random], :modulus => @subprime)
      @message_base = Rallot::Integer(:value => attrs[:message_base], :modulus => @prime)
    end
    
    #
    # Returns the partial decrytion of the given vote.
    #
    def partial_decrypt(vote)
      # TODO
    end
    
    #
    # Returns the final private key given a list of polynomials.
    #
    def final_private_key(polynomials)
      # TODO
    end
    
    def to_s
      "p#{@prime}g#{@generator}x#{@random}f#{@message_base}"
    end
    
    def self.from_s(s)
      match = /^p(\d+)g(\d+)x(\d+)f(\d+)$/.match(s)
      
      raise InvalidPrivateKeyException unless match
      
      PrivateKey.new :prime => match[1].to_i, :generator => match[2].to_i,:random => match[3].to_i, :message_base => match[4]
    end
  end
end