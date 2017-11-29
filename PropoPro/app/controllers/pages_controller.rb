class PagesController < ApplicationController
  def index
  end

  def company
  end

  def creative
    binding.pry
    if admin_signed_in?
      sign_out current_user
      redirect_to crtv_path
    end
  end

  def companydash
    if user_signed_in?
      sign_out current_admin
      redirect_to cmpny_path
    end
  end

  def creativedash
  end

end
