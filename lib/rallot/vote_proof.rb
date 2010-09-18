module Rallot
  class VoteProof
    attr_reader :p
    attr_reader :proof_list
    attr_reader :sum_proof
    
    def initialize
      # TODO
    end
    
    #
    # Computes a vote proof for a public key, a list of choices
    # and a number of minimun and maximum choices
    #
    def self.compute(vote, publicKey, choices, min, max)
      # TODO
    end
    
    def verify(vote, publicKey, choices, min, max)
      # TODO
    end
    
    def from_s
      # TODO
    end
    
    def to_s
      # TODO
    end
  end
end