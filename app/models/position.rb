class Position < ActiveRecord::Base
  attr_accessible :title, :election

  validates :title, :presence => true

  belongs_to :election
  has_and_belongs_to_many :candidates, :uniq => true
  has_many :votes
  scope :votes_per_candidate, ->(position, rank=1) {
    joins(:votes)
    .select('count(votes.rank) as score, votes.candidate_id as candidate_id')
    .where('votes.rank=?', [rank])
    .where('positions.id=?',[position.id])
    .group(:candidate_id, :rank)
    .order(:score)
  }
  def self.most_votes(position, rank=1)
      most_votes = votes_per_candidate(position, rank).limit(1)
      if most_votes.length > 0
        most_votes[0].score
      else
        0
      end
  end
  def self.winners(position, rank=1)
    Candidate.where(id: self.winner_candidate_ids(position, rank))
  end
  def self.winner_candidate_ids(position, rank=1)
    votes_per_candidate(position, rank).having('score=?',[self.most_votes(position, rank)]).map(&:candidate_id)
  end
end
