class ProposalsController < ApplicationController
  def show
    @proposal = Proposal.find(params[:id])
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

end
