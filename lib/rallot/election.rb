class Election
  attr_reader :prime
  attr_accessor :votes
  
  def initialize(prime)
    @prime = prime
    @votes = []
  end
  
  #
  # Cast the given vote in this election
  #
  def cast_vote(vote)
    @votes << vote
  end
  
  #
  # Sum the votes cast in this election
  # This is the product of the votes modulo the prime.
  # Return a vote representing the total of the given list of votes
  # 
  def sum_votes
    # TODO
  end
  
  #
  # Gets the final sum given the partial sums, the coefficients, the vote
  # representing the sum, and the master public key.
  #
  def final_sum(partial_sums, coefficients, sum, master_key)
    # TODO
  end
end