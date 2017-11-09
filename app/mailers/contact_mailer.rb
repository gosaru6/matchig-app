class ContactMailer < ApplicationMailer
  def contact_mail(recipient_user)
    @user = recipient_user

    mail to: @user.email , subject: "メッセージが届きました"
  end
end
