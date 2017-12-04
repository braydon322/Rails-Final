class Proposal < ActiveRecord::Base
  belongs_to :admin

  def user
    User.find(self.user_id)
  end

  def user=(new_user)
    self.user_id = new_user.id
  end

end
