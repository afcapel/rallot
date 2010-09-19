require 'gmp'

module Rallot
  extend self
  
  def Integer(*args,&block) 
    integer = case args[0]
    when RallotInteger
      args[0]
    when Integer
      if args.size >= 2 && Integer === args[1]
        RallotInteger.new(:value => args[0], :modulus => args[1])
      else
        RallotInteger.new(:value => args[0], :modulus => 0)
      end
    when String
      if args.size >= 2
        RallotInteger.new(:value => args[0].to_i, :modulus => args[1].to_i)
      else
        RallotInteger.new(:value => args[0].to_i, :modulus => 0)
      end
    when Hash
      RallotInteger.new(args[0])
    when NilClass
      nil
    else
      raise ArgumentError.new "can't convert #{args[0].class} to RallotInteger"
    end
    
    return integer
  end

  #
  # Arbitrary precission integer for modular arithmetic.
  # Internally, integers are used to represent the value and the modulus.
  #
  class RallotInteger < Numeric
    include Comparable
    
    # RallotIntegers are inmutable
    attr_reader :value 
    attr_reader :modulus

    def initialize(attrs={})
      @value = GMP::Z.new(attrs[:value].to_i)
      @modulus = GMP::Z.new(attrs[:modulus].to_i)
      
      @value = @value.modulo(@modulus) if @modulus && @modulus > 0
    end
    
    def ==(other)
      return true if self.equal? other # They are the same object 
      
      if other.respond_to? :value
        return self.value == other.value
      else
        return self.value == other
      end
    end

    def +(other)      
      return RallotInteger.new(:value => self.value + other, :modulus => self.modulus)
    end
    
    def -(other)      
      return RallotInteger.new(:value => self.value - other, :modulus => self.modulus)
    end
    
    def /(other)      
      return RallotInteger.new(:value => (self.value / other).floor, :modulus => self.modulus)
    end
    
    def <=>(other)
      other = Rallot::Integer(other)
      return self.value <=> other.value
    end
    
    def is_divisible?(divisor)
      @value / divisor == 0
    end
    
    def *(other)
      if other.respond_to? :value
        mult_value = self.value * other.value
      else
        mult_value = self.value * other
      end
      
      return Rallot::Integer(:value =>mult_value , :modulus => self.modulus)
    end
    
    def pow(exponent)
      gmp_value = GMP::Z.new(value)
      gmp_exponent = GMP::Z.new(exponent.to_i)
      
      if modulus && modulus > 0
        powered = gmp_value.powmod(gmp_exponent, modulus.to_i)
      else        
        powered =  gmp_value ** gmp_exponent
      end
      Rallot::Integer(powered, modulus)
    end
    
    alias ** pow
    
    def self.random(*args)
      
      case args[0]
      when Hash
        options = args[0]
        if options[:max]
          rnd_value = GMP::RandState.new.urandomm(options[:max].to_i)
          random = Rallot::Integer(rnd_value.to_i, options[:max].to_i)
        elsif options[:max_length]
          rnd_value = GMP::RandState.new.urandomb(128)
          random = Rallot::Integer(rnd_value, 2**options[:max_length]-1)
        else
          raise ArgumentError.new "You must specify either a :max or a :max_length option"
        end
      when Integer
         random = Rallot::Integer(GMP::RandState.new.urandomm(args[0]), args[0])
      else
        raise ArgumentError.new "Can't create random value from #{args[0].class}"
      end
      
      return random
    end
    
    def self.safe_prime(length)
      random = GMP::RandState.new.urandomb(length)
      prime = random.nextprime
      return Rallot::Integer(prime.to_i)
    end
    
    def probable_prime?
      GMP::Z.new(value).probab_prime?
    end
    
    def to_s
      value.to_s
    end
    
    def to_i
      value.to_i
    end
    
    alias to_int to_i
    
    def coerce(o)
       [Rallot::Integer(o), self]
    end 
  end

end