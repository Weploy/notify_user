module NotifyUser
  class Delivery < ActiveRecord::Base
    self.table_name = "notify_user_deliveries"

    validates :notification, presence: true
    validates :channel, presence: true
    validates :deliver_in, presence: true

    belongs_to :notification, class_name: BaseNotification.name

    after_commit :deliver!, on: :create

    def log_response_for_device(device_id, response)
      current_responses = responses || {}
      self.update(responses: current_responses.merge({ device_id => { status: response.status, body: response.body } }))
    end

    private

    def deliver!
      DeliveryWorker.enqueue(id, run_at: deliver_in.seconds.from_now)
    end
  end
end
