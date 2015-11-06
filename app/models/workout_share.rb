class WorkoutShare
  include ActiveModel::Model

  attr_accessor :workout, :emails

  validates :workout, presence: true
  validates :emails, presence: true, format: {
    with: /\A((\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*)\s*[,]{0,1}\s*)+\z/i,
    allow_blank: true
  } # multiple valid emails separated by commas (but allows last empty comma :\)

  # TODO spec
  def send_emails
    valid? && send_email_to_each_address
  end

  private

  def send_email_to_each_address
    emails.split(',').each do |email|
      email = email.strip
      next if email.blank?
      # TODO send email
    end
    true
  end

end
