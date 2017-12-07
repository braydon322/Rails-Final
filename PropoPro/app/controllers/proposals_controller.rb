class ProposalsController < ApplicationController
  def new
    @proposal = Proposal.new
    @proposal.reasons.build
    # @proposal.milestones.new
  end

  def show
    @proposal = Proposal.find(params[:id])
  end

  def price_up
    @proposals = Proposal.where(:admin_id => current_admin.id).order(budget: :asc)
    render "pages/creativedash"
  end

  def price_down
    @proposals = Proposal.where(:admin_id => current_admin.id).order(budget: :desc)
    render "pages/creativedash"
  end

  def date_up
    @proposals = Proposal.where(:admin_id => current_admin.id).order(created_at: :asc)
    render "pages/creativedash"
  end

  def date_down
    @proposals = Proposal.where(:admin_id => current_admin.id).order(created_at: :desc)
    render "pages/creativedash"
  end

  def signed
    @proposals = Proposal.where(:admin_id => current_admin.id, :proposal_accepted => true)
    render "pages/creativedash"
  end

  def unsigned
    @proposals = Proposal.where(:admin_id => current_admin.id, :proposal_accepted => !true)
    render "pages/creativedash"
  end

  def create
    if User.find_by(:email => params[:proposal][:email])
      @user = User.find_by(:email => params[:proposal][:email])
      params[:proposal][:user_id] = @user.id
      params[:proposal][:admin_id] = current_admin.id
      @proposal = current_admin.proposals.create(proposal_params)
      @proposal.admin_id = current_admin.id
      @proposal.save
    else
      @proposal= Proposal.create(proposal_params)
      @proposal.admin_id = current_admin.id
      @proposal.user = User.create(:admin_id => current_admin.id, :name => "", :email => params[:proposal][:email], :password => "Password123", :password_confirmation => "Password123")
      @proposal.save
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
      elsif params[:proposal][:name]
          @proposal.user.name = params[:proposal][:name]
          @proposal.user.save
          redirect_to cmpny_path
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
    params.require(:proposal).permit(
      :title,
      :budget,
      :invoice_paid,
      :proposal_accepted,
      :milestone_1,
      :milestone_2,
      :milestone_3,
      :email,
      :user_id,
      :admin_id,
      reasons: [
        :id,
        :proposal_id,
        :content
      ])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end
