class AssignmentsMailer < ApplicationMailer
  def shift_assigned_email(user, offspring, assignment)
    @user = user
    @assignment = assignment
    @offspring = offspring

    mail(to: user.email, subject: I18n.t('activemailer.subjects.assignment_added'))
  end
end
