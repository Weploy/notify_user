require 'gcm'

module NotifyUser
  class Gcm < Push
    PAYLOAD_LIMIT = 4096

    attr_accessor :client, :push_options

    def initialize(notifications, devices, options)
      super(notifications, devices, options)
      @delivery = delivery_for_notification('gcm')
    end

    def push
      send_notifications
    end

    def client
      @client ||= GCM.new(ENV['GCM_API_KEY'])
    end

    def valid?(payload)
      payload.to_json.bytesize <= PAYLOAD_LIMIT
    end

    private

    attr_accessor :delivery

    def build_notification
      Factories::Gcm.build(@notification, @options)
    end

    def send_notifications
      return unless device_tokens.any?
      notification_data = build_notification()

      response = client.send(device_tokens, notification_data)

      log_response_to_delivery('gcm', response)

      Device.where(
        token: not_registered_device_tokens(response)
      ).destroy_all

      true
    end

    def not_registered_device_tokens(response)
      response.fetch(:not_registered_ids, [])
    end
  end
end
