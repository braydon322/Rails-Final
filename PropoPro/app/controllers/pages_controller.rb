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
    @proposals = Proposal.where(:email => current_user.email)
  end

  def creativedash
    @proposals = Proposal.where(:admin_id => current_admin.id)
  end

end
