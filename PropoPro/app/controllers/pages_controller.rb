class PagesController < ApplicationController
  def index
  end

  def company
    if user_signed_in?
      redirect_to cmpny_path
    end
  end

  def creative
    if admin_signed_in?
      redirect_to crtv_path
    end
  end

  def companydash
    @email = current_user.email
    @id = current_user.id
    @proposals = Proposal.where(:user_id => @id)
  end

  def creativedash
    @proposals = Proposal.where(:admin_id => current_admin.id)
  end

end
