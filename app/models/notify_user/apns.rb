require_relative 'apn_connection'
require 'houston'

module NotifyUser
  class Apns < Push
    NO_ERROR = -42
    INVALID_TOKEN_ERROR = 8

    attr_accessor :push_options

    def initialize(notifications, devices, options)
      super(notifications, devices, options)

      @push_options = setup_options
      @devices = devices
    end

    def push
      APNConnection::POOL.with do |apn_connection| 
        send_notifications(apn_connection)
      end
    end

    private

    attr_accessor :devices

    def setup_options
      space_allowance = PAYLOAD_LIMIT - used_space

      mobile_message = ''
      if @notification.parent_id
        parent = @notification.class.find(@notification.parent_id)
        mobile_message = parent.mobile_message(space_allowance)
      else
        mobile_message = @notification.mobile_message(space_allowance)
      end
      mobile_message.gsub!('\n', "\n")

      push_options = {
        alert: mobile_message,
        badge: @notification.count_for_target,
        category: @notification.params[:category] || @notification.type,
        custom_data: @notification.params,
        sound: @options[:sound] || 'default'
      }

      if @options[:silent]
        push_options.merge!({
          alert: '',
          sound: '',
          content_available: true
        }).delete(:badge)
      end

      push_options
    end

    def valid?(payload)
      payload.to_json.bytesize <= PAYLOAD_LIMIT
    end

    def send_notifications(apn_connection)
      connection = apn_connection.connection
      connection.open if connection.closed?

      Rails.logger.info "PAYLOAD"
      Rails.logger.info "----"
      Rails.logger.info "#{@push_options}"

      unless valid?(@push_options)
        Rails.logger.info "Error: Payload exceeds size limit."
      end

      devices.each_with_index do |device, index|
        notification = ::Houston::Notification.new(@push_options.dup.merge({ token: device.token, id: index }))
        connection.write(notification.message)
      end

      error_index = io_errors(apn_connection)

      if error_index == NO_ERROR
        return true
      else
        # Resend all notifications after the once that produced the error:
        send_notifications(apn_connection)
      end
    rescue OpenSSL::SSL::SSLError, Errno::EPIPE, Errno::ETIMEDOUT => e
      Rails.logger.error "[##{connection.object_id}] Exception occurred: #{e.inspect}."
      apn_connection.reset
      Rails.logger.debug "[##{connection.object_id}] Socket reestablished."
      retry
    end

    def io_errors(apn_connection)
      connection = apn_connection.connection
      error_index = NO_ERROR
      ssl = connection.ssl

      Rails.logger.info "READING ERRORS"
      Rails.logger.info "----"
      read_socket, write_socket = IO.select([ssl], [], [ssl], 1)
      Rails.logger.info "#{ssl}"

      if (read_socket && read_socket[0])
        error = connection.read(6)

        Rails.logger.info "#{error}"

        if error
          command, status, error_index = error.unpack("ccN")

          Rails.logger.info "Error: #{status} with id: #{error_index}."

          # Remove all the devices prior to the error (we assume they were successful), and close the current connection:
          if error_index != NO_ERROR
            device = devices.at(error_index)

            # If we encounter the Invalid Token error from APNS, just remove the device:
            if status == INVALID_TOKEN_ERROR
              Rails.logger.info "Invalid token encountered, removing device. Token: #{device.token}."
              device.destroy
            end

            devices.slice!(0..error_index)
            apn_connection.reset
          end
        end
      end
      return error_index
    end
  end
end
