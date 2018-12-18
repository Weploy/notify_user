module NotifyUser
  module Factories
    module Gcm
      include Base

      def self.build(notification, options = {})
        {
          data: {
            notification_id: notification.id,
            message: fetch_message(notification),
            type: options[:category] || notification.type,
            unread_count: count_for_target(notification.target),
            custom_data: notification.sendable_params
          }
        }
      end

      def self.build_silent(notification, options = {})
        {
          data: {
            notification_id: notification.id,
            message: ''
          }
        }
      end
    end
  end
end
