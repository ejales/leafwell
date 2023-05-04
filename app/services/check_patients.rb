class CheckPatients
  def call
    patients = Patient.where("created_at < ?", 1.month.ago)
    message = <<~TXT.html_safe
      <div class="text-justify">Hello patient,<br><br>
        <p>We hope you are doing well. We would like to remind you of the importance of keeping
          your health information up to date with us, especially if there have been any changes
          in the symptoms or medical conditions that you reported when registering for medicinal cannabis use.
        </p>

        <p>Therefore, we kindly ask you to update your information so that we can ensure that the treatment offered
            is as appropriate and effective as possible.
        </p>

        <p>If you have any questions, please do not hesitate to contact us.</p>

        Sincerely,<br>
        Leafwell Team
      </div>
      <br><br>
    TXT
    
    patients.each do |patient|
      LeafwellMailer.with(user: patient.user.email, message: message).notification.deliver_now
    end
  end
end