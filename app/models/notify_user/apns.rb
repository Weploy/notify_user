require_relative 'apn_connection'

module NotifyUser
  class Apns < Push
    attr_accessor :push_options

    def initialize(notifications, devices, options)
      super(notifications, devices, options)
      @delivery = apns_delivery_for_notification
      @devices = devices
    end

    def push
      APNConnection::POOL.with do |connection|
        send_notifications(connection)
      end
    end

    private

    attr_accessor :devices
    attr_accessor :delivery

    def build_notification(device)
      if @options[:silent]
        return Factories::Apns.build_silent(@notification, device.token, @options)
      else
        return Factories::Apns.build(@notification, device.token, @options)
      end
    end

    def send_notifications(connection)
      devices.each_with_index do |device, index|
        notification = build_notification(device)
        response = connection.write(notification)

        raise "Timeout sending a push notification" unless response

        log_response_to_delivery(device, response)

        if response.status == '410' ||
            (response.status == '400' && response.body['reason'] == 'BadDeviceToken')
          Rails.logger.info "Invalid token encountered, removing device. Token: #{device.token}."
          device.destroy
        else
          Rails.logger.info "Notification for token: #{device.token} responded with status #{response.status}"
        end
      end

      return true
    end

    def apns_delivery_for_notification
      Delivery.find_by(notification: @notification, channel: 'apns')
    end

    def log_response_to_delivery(device, response)
      return unless delivery.present?
      delivery.log_response_for_device(device, response)
    end
  end
end
