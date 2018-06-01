require 'spec_helper'

RSpec.describe NotifyUser::Expo, type: :model do
  let(:user) { create(:user) }
  let(:user_tokens) { ['a_token'] }
  let(:notification) { create(:notify_user_notification, params: {}, target: user) }
  let(:devices) { [] }

  subject { described_class.new([notification], devices, {}) }

  describe 'push' do
    context 'when there is no devices' do
      let(:devices) { [] }

      it 'should return false' do
        expect(subject.push).to eq(false)
      end
    end

    context 'when there is a device' do
      let(:client) { instance_double(Exponent::Push::Client) }
      let(:response) { double('response', status: status, body: body) }

      before do
        devices << create_device_double

        expect(Exponent::Push::Client).to receive(:new).and_return(client)
        expect(client).to receive(:publish).and_return(response)
      end

      context 'when the status is 4xx or 5xx' do
        let(:status) { '400' }
        let(:body) do
          {
            'errors' => [{
              'code' => 'INTERNAL_SERVER_ERROR',
              'message' => 'An unknown error occurred.'
            }]
          }
        end

        it 'should return false' do
          expect(subject.push).to eq(false)
        end
      end

      context 'when the status is 200' do
        let(:status) { '200' }
        let(:body) do
          {
            'data' => [{
              'status' => data_status,
              'message' => data_message,
              'details' => data_details
            }]
          }
        end

        context 'when a device is no longer registered' do
          let(:data_status) { 'error' }
          let(:data_message) { '"ExponentPushToken[cocolasticot]" is not a registered push notification recipient' }
          let(:data_details) { { 'error' => 'DeviceNotRegistered' } }

          it 'should return false' do
            expect(devices.first).to receive(:destroy)
            expect(subject.push).to eq(false)
          end
        end

        context 'when a generic error is returned' do
          let(:data_status) { 'error' }
          let(:data_message) { 'A different message.' }
          let(:data_details) { { 'error' => 'AGenericError' } }

          it 'should return false' do
            expect(subject.push).to eq(false)
          end
        end

        context 'when everything worked just fine' do
          let(:data_status) { 'a success status' }
          let(:data_message) { 'It all worked so well!' }
          let(:data_details) { {} }

          it 'should return true' do
            expect(subject.push).to eq(true)
          end
        end
      end
    end
  end
end
