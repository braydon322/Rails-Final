class UserMailer < ActionMailer::Base
  # default to: 'me@braydonwhitmarsh.com'

  def new_account_email(user)
    @user = user
    mail(to: @user.email, subject: 'You have a new proposal!')
  end

  def new_proposal_email(user)
    @user = user
    mail(to: @user.email, subject: 'You have a new proposal!')
  end
end
