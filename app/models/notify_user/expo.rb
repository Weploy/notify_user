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
      devices.each do |device|
        response = client.publish(
          [Factories::Expo.build(@notification, device.token, @options)]
        )

        raise 'Timeout sending a push notification' unless response

        log_response_to_delivery(device.id, response)

        if response.status == '200'
          success = true
          response.body['data'].each do |result|
            if result['status'] == 'error'
              success = false
              device.destroy if result.dig('details', 'error') == 'DeviceNotRegistered'
              Rails.logger.info("Expo error: #{result.dig('details', 'error')} - #{result['message']}")
            end
          end
          return success
        else
          response.body['errors'].each do |error|
            Rails.logger.info("Expo error: #{error['code']} - #{error['message']}")
          end
          return false
        end
      end
    end
  end
end
