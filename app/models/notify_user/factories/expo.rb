module NotifyUser
  module Factories
    module Expo
      include Base

      def self.build(notification, token, options = {})
        {
          to: token,
          data: options[:data],
          title: options[:title],
          body: fetch_message(notification),
          sound: options[:sound] || 'default',
          ttl: options[:ttl],
          expiration: options[:expiration],
          priority: options[:priority],
          badge: count_for_target(notification.target).to_s,
          vibrate: options[:vibrate] || true,
        }.compact
      end
    end
  end
end
