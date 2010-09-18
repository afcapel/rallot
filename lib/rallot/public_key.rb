module Rallot
  class InvalidPublicKeyException < StandardError; end
  
  class PublicKey
    attr_reader :prime        # P in Adder
    attr_reader :subprime     # Q in Adder
    attr_reader :generator    # G in Adder
    attr_reader :public_value # H in Adder
    attr_reader :message_base # F in Adder
    
    def initialize(attrs)
      @prime = Rallot::Integer(attrs[:prime])
      @subprime = Rallot::Integer(attrs[:subprime])
      @generator = Rallot::Integer(attrs[:generator])
      @public_value = Rallot::Integer(attrs[:public_value])
      @message_base = Rallot::Integer(attrs[:message_base])
    end
    
    #
    # Creates a partial public key with the given length in bits.
    #
    def self.make_partial_key(length)
      # TODO
    end
    
    
    #
    # Creates the corresponding private key of this public key.
    #
    def generate_private_key
      # TODO
    end
    
    #
    # Encrypts the given choice given the base.
    #
    def encrypt(base)
      # TODO
    end
    
    #
    # Encrypts a polynomial of the given value.
    #
    def encryptPolynomial(message)
      # TODO
    end
    
    def self.from_s(s)
      
      match = /^p(\d+)g(\d+)h(\d+)f(\d+)$/.match(s)
      
      raise InvalidPublicKeyException unless match
      
      p = match[1].to_i
      q = (p-1)/2
      g = match[2].to_i
      h = match[3].to_i
      f = match[4].to_i
      
      PublicKey.new(:prime => p, :subprime => q, :generator => g, :public_value => h, :message_base => f)
    end
    
    def to_s
      # TODO
    end
    
  end
end