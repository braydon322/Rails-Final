class ProposalsController < ApplicationController
  def new
  end

  def show
    @proposal = Proposal.find(params[:id])
  end

  def create
    if User.find_by(:email => params[:proposal][:email])
      @user = User.find_by(:email => params[:proposal][:email])
      params[:proposal][:user_id] = @user.id
      params[:proposal][:admin_id] = current_admin.id
      @proposal= Proposal.create(proposal_params)
      current_admin.proposals << @proposal
      UserMailer.new_proposal_email(@user).deliver_now
    else
      binding.pry
      password = "Password123"
      @user = User.create(:admin_id => current_admin.id, :name => "Billy", :email => params[:proposal][:email], :password => password, :password_confirmation => password)
      params[:proposal][:user_id] = @user.id
      params[:proposal][:admin_id] = current_admin.id
      @proposal= Proposal.create(proposal_params)
      @user << @proposal
      UserMailer.new_account_email(@user).deliver_now
    end
    redirect_to crtv_path
  end

  def update
    if admin_signed_in?
      @proposal = Proposal.find(params[:id])
      @proposal.update(proposal_params)
      redirect_to crtv_path
    else
      redirect_to new_admin_session_path
    end
  end

  private

  def proposal_params
    params.require(:proposal).permit(:title, :budget, :invoice_paid, :proposal_accepted, :email)
  end

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end

end
