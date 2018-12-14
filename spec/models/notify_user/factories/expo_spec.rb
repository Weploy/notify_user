require 'spec_helper'

RSpec.describe NotifyUser::Factories::Expo, type: :factory do
  let(:user) { create(:user) }
  let(:notification) { create(:notify_user_notification, params: {}, target: user) }
  let(:token) { 'a_token' }
  let(:options) { {} }

  subject { described_class.build(notification, token, options) }

  describe '.build' do
    context 'without options' do
      it 'sets the sets the to field to the supplied token' do
        expect(subject[:to]).to eq token
      end

      it 'sets body to the notification message' do
        expect(subject[:body]).to eq 'New Post Notification happened with {}'
      end

      it 'sets the sound to default' do
        expect(subject[:sound]).to eq 'default'
      end

      it 'sets vibrate to true' do
        expect(subject[:vibrate]).to eq true
      end

      it 'sets the badge to 1' do
        expect(subject[:badge]).to eq '1'
      end
    end
  end
end
