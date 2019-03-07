require 'spec_helper'
require 'support/test_fcm_connection'

module NotifyUser
  describe Fcm, type: :model do
    let(:user) { create(:user) }
    let(:notification) { create(:notify_user_notification, params: {}, target: user) }
    let(:user_tokens) { ['a_token'] }

    before :each do
      allow_any_instance_of(Fcm).to receive(:device_tokens) { user_tokens }
      @client = TestFCMConnection.new
      allow_any_instance_of(Fcm).to receive(:client).and_return(@client)
    end

    describe 'push' do
      before :each do
        @fcm = Fcm.new([notification], [], {})
      end

      context 'without errors' do
        before :each do
          # Stub out send method with a successful response object, or maybe,
          # initialize TestFCMConnection with new(:success)
          # This would keep the spec file clean...
        end

        it 'returns true if no error' do
          expect(@fcm.push).to eq true
        end

        it 'sends to the device token of the notification target' do
          expect(@client).to receive(:send).with(user_tokens, kind_of(Hash))
          @fcm.push
        end

        it 'does not try to send to an empty token' do
          user_tokens = []
          allow_any_instance_of(Fcm).to receive(:device_tokens) { user_tokens }
          expect_any_instance_of(FCM).not_to receive(:send)
          @fcm.push
        end

        it 'sends multiple notifications' do
          multiple_tokens = %w(token_1 token_2 token_3)
          allow(@fcm).to receive(:device_tokens) { multiple_tokens }
          expect(@client).to receive(:send).once
            .with(multiple_tokens, kind_of(Hash))
          @fcm.push
        end
      end

      describe 'Delivery logging' do
        before do
          @mock_status = instance_double("status", status: "200", body: {})
          @delivery = instance_double('Delivery')
          @device = create_device_double

          allow(@fcm).to receive(:device_tokens) { [@device.token] }
          allow(@fcm).to receive(:delivery) { @delivery }
        end

        it 'calls the log method on delivery' do
          expect(@delivery).to receive(:log_response_for_device).with('fcm', anything)

          @fcm.push
        end
      end
    end
  end
end
