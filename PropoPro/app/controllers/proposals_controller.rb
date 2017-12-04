class ProposalsController < ApplicationController
  def new
    @proposal = Proposal.new
  end

  def show
    @proposal = Proposal.find(params[:id])
  end

  def sign
  end

  def create
    if User.find_by(:email => params[:proposal][:email])
      @user = User.find_by(:email => params[:proposal][:email])
      params[:proposal][:user_id] = @user.id
      params[:proposal][:admin_id] = current_admin.id
      @proposal= Proposal.create(proposal_params)
      @proposal.user = @user
      current_admin.proposals << @proposal
      # UserMailer.new_proposal_email(@user).deliver_now
    else
      password = "Password123"
      @user = User.create(:admin_id => current_admin.id, :name => "Billy", :email => params[:proposal][:email], :password => password, :password_confirmation => password)
      params[:proposal][:user_id] = @user.id
      params[:proposal][:admin_id] = current_admin.id
      @proposal= Proposal.create(proposal_params)
      # @user.proposals << @proposal
      # UserMailer.new_account_email(@user).deliver_now
    end
    redirect_to crtv_path
  end

  def update
      @proposal = Proposal.find(params[:id])
      if @proposal.proposal_accepted
        flash[:notice] = "You cannot change the proposal after it has already been signed."
        if current_admin
          redirect_to crtv_path
        else
          redirect_to cmpny_path
        end
      elsif params[:proposal][:password]
        if @proposal.user.valid_password?(params[:proposal][:password])
          @proposal.update(proposal_params)
          redirect_to cmpny_path
        else
          flash[:notice] = "Incorrect Password. Please try again"
          redirect_to sign_path
        end
      else
        @proposal.update(proposal_params)
        if current_admin
          redirect_to crtv_path
        else
          redirect_to cmpny_path
        end
      end
  end

  def destroy
    @proposal = Proposal.find_by(:id => params[:id])
    @proposal.destroy
    redirect_to crtv_path
  end

  private

  def proposal_params
    params.require(:proposal).permit(:title, :budget, :invoice_paid, :proposal_accepted, :email, :user_id, :admin_id, reason_attributes: [:reason])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end

end
