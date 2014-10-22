class Notifier

  # intended to be run via cron job at a safe point throughout the day
  # TODO: participant time zones and target send times?

  def self.daily_notification
    Participant.find_each(batch_size: 500).each do |p|
      t = p.tokens.create.value
      if p.contact_method == "phone"
        Sms.notify(p.phone_number, t)
      elsif p.contact_method == "email"
        Daily.notify(p, t).deliver
      else
        puts "!!??"
      end
    end
  end

end
