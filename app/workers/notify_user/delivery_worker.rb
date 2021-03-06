require 'que'

module NotifyUser
  class DeliveryWorker < Que::Job
    def run(delivery_id)
      delivery = Delivery.find(delivery_id)

      if delivery.notification.read?
        # TODO: Log things out
      else
        channel_name = delivery.channel
        channel_options = delivery.notification.class.channels[channel_name.to_sym] || {}
        channel_class = (channel_name + "_channel").camelize.constantize

        Rails.logger.info "Sending Notification #{delivery.notification.type} to: #{channel_name}"

        channel_class.deliver(delivery.notification_id, channel_options)
        delivery.update(sent_at: Time.zone.now)
      end
    end
  end
end
