class Proposal < ActiveRecord::Base
  belongs_to :admin

  def user
    User.find(self.user_id)
  end

  def user=(new_user)
    self.user_id = new_user.id
  end

  def terms
    price = helper.number_to_currency(self.budget, precision: 0)
    terms = "The Client agrees to pay the above mentioned #{price} as they receive the deliverables, delivered in the above set milestones."
    self.terms = terms
  end

  def helper
     @helper ||= Class.new do
       include ActionView::Helpers::NumberHelper
     end.new
   end

end
