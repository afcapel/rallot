module Rallot
  
  # Thrown by the from_s method of a Vote
  # to indicate that there was a parse error.
  class InvalidVoteException < StandardError; end
  
  class Vote
    attr_reader :cypherlist

    def initialize(*args)
      @cypherlist = args.flatten
    end

    def *(other)
      mult_cypherlist = []

      @cypherlist.each_index do |i|
        mult_cypherlist << self.cypherlist[i] * other.cypherlist[i]
      end

      return Vote.new(mult_cypherlist);
    end

    def self.from_s(s)
      cypherlist = []
      tokens = s.split(/\s/)
      
      begin
        tokens.each do |token|
          cypherlist << Rallot::ElGammalCypherText.from_s(token)
        end
      rescue InvalidElGammalCypherText
        raise InvalidVoteException
      end

      return Vote.new(cypherlist)
    end

    def to_s
      des = ""
      cypherlist.each do |cipher|
        des += "#{cipher.to_s} "
      end

      return des
    end
  end
end