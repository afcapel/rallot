module Rallot
  class InvalidPublicKeyException < StandardError; end
  
  def PublicKey(*args,&block)
    pub_key = case args[0]
    when Hash
      PublicKey.new args[0]
    when Numeric
      if args.size >= 4
        PublicKey.new :prime => args[0], :subprime => args[1], :generator => args[2], :public_value => args[3], :message_base => args[4]
      else
        raise InvalidPublicKeyException
      end
    else
      raise InvalidPublicKeyException.new "Can't create a Public key from #{args[0].class}"
    end
    
    pub_key
  end
  
  class PublicKey
    attr_reader :prime        # P in Adder
    attr_reader :subprime     # Q in Adder
    attr_reader :generator    # G in Adder
    attr_reader :public_value # H in Adder
    attr_reader :message_base # F in Adder
    
    def initialize(attrs)
        @prime = Rallot::Integer(attrs[:prime])
        @subprime = Rallot::Integer(attrs[:subprime]) if attrs[:subprime]
        @generator = Rallot::Integer(attrs[:generator])
        @public_value = Rallot::Integer(attrs[:public_value])
        @message_base = Rallot::Integer(attrs[:message_base])
    end
    
    #
    # Creates a partial public key with the given length in bits.
    #
    def self.make_partial_key_with_length(length)
      prime = RallotInteger.safe_prime(length)
      make_partial_key_with_prime(prime)
    end
    
    #
    # Creates a partial public key given the specified prime.
    #
    def self.make_partial_key_with_prime(prime)
     length = length.value if RallotInteger === length
      
      t = RallotInteger.random(:max => prime)
      
      g = t ** 2
      q = (prime - 1)/2
      begin
        a = RallotInteger.random(:max => prime)
      end while a < 1
      
      f = g ** a
      
      Rallot::PublicKey(prime, q, g, nil, f)
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
      h = @public_value ?  @public_value : 0
      
      return "p#{@prime}g#{@generator}h#{h}f#{@message_base}"
    end
    
  end
end