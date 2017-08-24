require 'spec_helper'

RSpec.describe NotifyUser::DeliveryWorker, type: :model do
  describe 'run' do
    it 'runs delivery via the required channel' do
      notification = create(:notify_user_notification)
      delivery = create(:delivery, notification: notification, channel: 'apns')

      expect(ApnsChannel).to receive(:deliver).with(notification.id, anything)
      described_class.enqueue(delivery.id)
    end

    it 'sets the send time on the delivery' do
      notification = create(:notify_user_notification)
      delivery = create(:delivery, notification: notification, channel: 'apns')

      expect do
        described_class.enqueue(delivery.id)
        delivery.reload
      end.to change(delivery, :sent_at).from(nil)
    end

    it 'doesnt run delivery if the notification has already been read' do
      notification = create(:notify_user_notification, read_at: Time.zone.now)
      delivery = create(:delivery, notification: notification, channel: 'apns')

      expect(ApnsChannel).not_to receive(:deliver)
      described_class.enqueue(delivery.id)
    end
  end
end
