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
      @value = attrs[:value].to_i
      @modulus = attrs[:modulus].to_i
      
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
      
      if modulus && modulus > 0
        pow = value.powmod(exponent.value, modulus)
        Rallot::Integer(pow)
      else
        new_value = value ** exponent
        Rallot::Integer(new_value, modulus)
      end
    end
    
    alias ** pow
    
    def self.random(length)
      
      random = rand(2**length-1)
      Rallot::Integer(random)
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