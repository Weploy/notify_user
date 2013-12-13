require "notify_user/engine"

module NotifyUser

  mattr_accessor :mailer_sender
  @@mailer_sender = nil

  # Used to set up NotifyUser from the initializer.
  def self.setup
    yield self
  end
end