module Rallot
  class InvalidPolynomialException < StandardError; end
  
  class Polynomial
    attr_reader :prime
    attr_reader :generator
    attr_reader :sub_prime
    attr_reader :message_base
    attr_reader :degree
    attr_reader :coefficients

    def initialize(attrs)
      @prime = attrs[:prime]                # P in Adder
      @generator = attrs[:generator]        # G in Adder
      @message_base = attrs[:message_base]  # F in Adder
      @degree = attrs[:degree]

      @sub_prime = attrs[:sub_prime] || (@prime-1)/2 
      
      if attrs[:coefficients]
        @coefficients = attrs[:coefficients]
      elsif attrs[:degree]
        @coefficients = []
        0.upto(degree).each do
          @coefficients << RallotInteger.random(:max => @sub_prime)
        end
      end
      
    end

    #
    # Evaluate the polynomial at the given point x
    #
    def evaluate(x)
      eval_sum = Rallot::Integer(0, @sub_prime)

      @coefficients.each_with_index do |coeff, index|
        eval_sum = eval_sum + coeff * (x ** index)
      end

      return eval_sum
    end

    #
    # Returns the Lagrange coefficients of this polynomial.
    #  
    def langrage_coefficients
      # TODO
    end

    def self.from_s(s)
      match = /^p(\d+)g(\d+)f(\d+)(\s\d+)*$/.match(s)
      
      raise InvalidPolynomialException unless match
      
      prime = match[1].to_i
      sub_prime = (prime-1)/2
      generator = match[2].to_i
      message_base = match[3].to_i
      
      coefficients = []
      4.upto(match.size).each do |index|
        coefficients << match[index].to_i
      end
      
      return Polynomial.new :prime => prime, 
                            :sub_prime => sub_prime, 
                            :generator => generator, 
                            :message_base => message_base, 
                            :coefficients => coefficients 
    end
    
    def to_s
      s = "p#{prime}g#{genrator}f#{message_base}"
      @coefficients.each do |coeff|
        s = s + " #{coeff}"
      end
      
      return s
    end
  end
end