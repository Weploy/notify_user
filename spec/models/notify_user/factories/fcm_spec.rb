require 'spec_helper'

describe NotifyUser::Factories::Fcm do
  describe '#present' do
    before :each do
      user = create(:user)
      @notification = create_notification_for_user(user)
    end

    describe '.build' do
      before :each do
        @fcm = described_class.build(@notification, {})
      end

      it 'sets the notification id' do
        expect(@fcm[:data][:notification_id]).to eq @notification.id
      end

      it 'sets the mobile message' do
        expect(@fcm[:data][:message]).to eq 'New Post Notification happened with {}'
      end

      it 'sets the badge to 1' do
        expect(@fcm[:data][:unread_count]).to eq 1
      end

      it 'sets the notification category' do
        expect(@fcm[:data][:type]).to eq 'NewPostNotification'
      end

      it 'sets the custom data with params' do
        expect(@fcm[:data][:custom_data]).to eq({})
      end
    end
  end

  def create_notification_for_user(user, options = {})
    NewPostNotification.create({ target: user }.merge(options))
  end
end
