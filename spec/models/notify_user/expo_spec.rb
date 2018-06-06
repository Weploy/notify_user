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

      before do
        devices << create_device_double
        expect(Exponent::Push::Client).to receive(:new).and_return(client)
      end

      it 'should return false when a generic error is raised' do
        expect(client).to receive(:publish).and_raise(Exponent::Push::Error)
        expect(subject.push).to eq(false)
      end

      it 'should destroy the device return false if DeviceNotRegisteredError is raised' do
        expect(client).to receive(:publish).and_raise(Exponent::Push::DeviceNotRegisteredError)
        expect(devices.first).to receive(:destroy)
        expect(subject.push).to eq(false)
      end

      it 'should return true if no error is raised' do
        expect(client).to receive(:publish)
        expect(subject.push).to eq(true)
      end
    end
  end
end
