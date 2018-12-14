require 'exponent-server-sdk'

module NotifyUser
  class Expo < Push
    PAYLOAD_LIMIT = 4096

    attr_accessor :push_options

    def initialize(notifications, devices, options)
      super(notifications, devices, options)
      @delivery = delivery_for_notification('expo')
    end

    def push
      send_notifications
    end

    private

    attr_accessor :delivery, :devices

    def client
      @client ||= Exponent::Push::Client.new
    end

    def valid?(payload)
      payload.to_json.bytesize <= PAYLOAD_LIMIT
    end

    def send_notifications
      return false unless devices.any?
      success = true
      devices.each do |device|
        begin
          client.publish([Factories::Expo.build(@notification, device.token, @options)])
        rescue Exponent::Push::DeviceNotRegisteredError => error
          success = false
          device.destroy
          Rails.logger.info("Expo error: #{error.message}")
        rescue Exponent::Push::Error => error
          success = false
          Rails.logger.info("Expo error: #{error.message}")
        end
      end
      success
    end
  end
end
