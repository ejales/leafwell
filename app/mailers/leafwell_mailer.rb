class LeafwellMailer < ApplicationMailer
  def notification
    mail(to: params[:user], subject: 'Leafweel - Update your information')
  end
end
