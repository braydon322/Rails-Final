class Proposal < ActiveRecord::Base
  belongs_to :admin

  def email
    @email = User.find(self.user_id).email
  end
end
