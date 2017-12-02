class PagesController < ApplicationController
  def index
    if current_user
      redirect_to cmpny_path
      flash[:notice] = "You are already logged in."
    elsif current_admin
      redirect_to crtv_path
      flash[:notice] = "You are already logged in."
    end
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

  def sign
  end

  def companydash
    @email = current_user.email
    @id = current_user.id
    @proposals = Proposal.where(:email => @email)
  end

  def creativedash
    @proposals = Proposal.where(:admin_id => current_admin.id)
  end

end
