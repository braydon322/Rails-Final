class PagesController < ApplicationController
  def index
  end

  def company
    if user_signed_in?
      sign_out current_admin
    end
  end

  def creative
    if admin_signed_in?
      sign_out current_user
    end
  end

  def companydash
    @proposals = Proposal.find_by(:email => current_user.email)
  end

  def creativedash
  end

end
