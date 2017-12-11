class Proposal < ActiveRecord::Base
  belongs_to :admin
  has_one :user, through: :admin
  has_many :reasons
  has_many :milestones
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :title,  presence: true, length: { maximum: 50 }
  validates :email, presence: true , format: { with: VALID_EMAIL_REGEX }


  def user
    User.find_or_create_by(self.user_id)
  end

  def user=(new_user)
    self.user_id = new_user.id
  end

  def reasons=(hash)
    self.save
    if self.reasons[0]
      @reason = self.reasons[0]
      if hash[:content] != "" && hash[:content].length > 5
        @reason.content = hash[:content]
      end
      @reason.save
      self.save
    else
      @reason = self.reasons.create(:content => hash[:content], :proposal_id => self.id)
    end
    self.save
  end

  def reasons
    Reason.where(:proposal_id => self.id)
  end

  def terms
    price = helper.number_to_currency(self.budget, precision: 0)
    terms =
    "The Client agrees to pay the above mentioned #{price} as they receive the deliverables, delivered in both the above, and below mentioned milestones."
    self.terms = terms
  end

  def helper
     @helper ||= Class.new do
       include ActionView::Helpers::NumberHelper
     end.new
  end

end
