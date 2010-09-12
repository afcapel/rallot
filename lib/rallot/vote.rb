module Rallot
  class Vote
    attr_reader :cipher_list

    def initialize(*args)
      @cipher_list = args.flatten
    end

    def *(other)
      mult_cipher_list = []

      @cipher_list.each_index do |i|
        mult_cipher_list << self.cipher_list[i] * other.cipher_list[i]
      end

      return Vote.new(mult_cipher_list);
    end

    def self.from_s(s)
      cipher_list = []
      tokens = s.split(/\s/)
      tokens.each do |token|
        cipher_list << Rallot::ElGammalCypherText.from_s(token)
      end

      return Vote.new(cipher_list)
    end

    def to_s
      des = ""
      cipher_list.each do |cipher|
        des += "#{cipher.to_s} "
      end

      return des
    end
  end
end