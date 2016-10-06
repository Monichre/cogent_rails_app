class InviteMailer < ApplicationMailer
  def invitation(invitation)
    @greeting = "Hi"
    @invitation = invitation

    mail to: invitation.recipient_email
  end
end
