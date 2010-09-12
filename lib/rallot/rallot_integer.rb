require 'gmp'

module Rallot
  extend self
  
  def Integer(*args,&block) 
    integer = case args[0] 
    when Fixnum
      RallotInteger.new(:value => args[0], :modulus => 0)
    when Hash
      RallotInteger.new(args[0])
    end
    
    return integer
  end

  #
  # Arbitrary precission integer for modular arithmetic.
  # Internally, GMP integers are used to represent the value and the modulus.
  #
  class RallotInteger
    include Comparable
    
    # RallotIntegers are inmutable
    attr_reader :value 
    attr_reader :modulus

    def initialize(attrs={})
      @value = GMP::Z.new(attrs[:value] || attrs[:v])
      @modulus = GMP::Z.new(attrs[:modulus] || attrs[:m])
      @value = @value.tmod(@modulus) if @modulus && @modulus > 0
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
      raise ArgumentError "You can only compare two Rallot integers" unless other.respond_to? :value
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
      
  end

end