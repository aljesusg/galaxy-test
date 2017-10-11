class ApplicationMailer < ActionMailer::Base
  default from: ENV["GMAIL_USERNAME"] || 'mail@example.com'
  layout 'mailer'
end
