class Reason < ActiveRecord::Base
  belongs_to :proposal

  def proposal
    Proposal.find(self.proposal_id)
  end
end
