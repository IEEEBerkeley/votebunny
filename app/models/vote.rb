class Vote < ActiveRecord::Base
  attr_accessible :user, :position, :rank, :candidate

  belongs_to :user
  belongs_to :position
  belongs_to :candidate

  scope :for_position, ->(position, rank=1){ where( position_id: position, rank: rank) }
  scope :primary_for, ->(position){ for_position(position, 1)}
  # vote for a candidate for a position
  # assumes correct input is being passed
  def self.vote(user, position, candidate, rank)
    begin
      Vote.create!(:user => user, :position => position, :candidate => candidate, :rank => rank)
    rescue
      # remove all votes from this user for this position
      votes = Vote.where("user_id = ? AND position_id = ?", user.id, position.id)
      votes.each do |vote|
        vote.destroy
      end
      # do it again
      v = Vote.new(:user => user, :position => position, :candidate => candidate, :rank => rank)
      v.save
    end
  end

  def self.count_votes(position)
    votes = {}
    ranks = [3, position.candidates.count].min
    position.candidates.each do |candidate|
      votes[candidate.name] = {}
      1.upto(ranks) do |rank|
        num_votes = Vote.where("position_id = ? AND candidate_id = ? AND rank = ?", position.id, candidate.id, rank).count
        votes[candidate.name][rank] = num_votes
      end
    end
    return votes
  end

end
