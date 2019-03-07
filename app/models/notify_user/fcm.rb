require 'fcm'

module NotifyUser
  class Fcm < Push
    PAYLOAD_LIMIT = 4096

    attr_accessor :push_options

    def initialize(notifications, devices, options)
      super(notifications, devices, options)
      @delivery = delivery_for_notification('fcm')
    end

    def push
      send_notifications
    end

    def client
      @client ||= FCM.new(ENV['FCM_API_KEY'])
    end

    def valid?(payload)
      payload.to_json.bytesize <= PAYLOAD_LIMIT
    end

    private

    attr_accessor :delivery

    def build_notification
      if @options[:silent]
        Factories::Fcm.build_silent(@notification, @options)
      else
        Factories::Fcm.build(@notification, @options)
      end
    end

    def send_notifications
      return unless device_tokens.any?
      notification_data = build_notification

      response = client.send(device_tokens, notification_data)
      not_registered_tokens = response.fetch(:not_registered_ids, [])

      log_response_to_delivery('fcm', response)

      @devices.each do |device|
        device.destroy if not_registered_tokens.include?(device.token)
      end

      true
    end
  end
end
