module NotifyUser
  class Unsubscribe < ActiveRecord::Base
    self.table_name = "notify_user_unsubscribes"

    # The user to send the notification to
    belongs_to :target, polymorphic: true

    validates_presence_of :target_id, :target_type, :target, :type

    validates :type, :uniqueness => {:scope => [:target_type, :target_id]}

    self.inheritance_column = :_type_disabled

    if Rails.version.to_i < 4
      attr_accessible :target, :type, :group_id
    end

    def self.for_target(target)
      where(target_id: target.id)
      .where(target_type: target.class.base_class.name)
    end

    def self.toggle_status(target, type)
      if NotifyUser::Unsubscribe.has_unsubscribed_from?(target, type)
        NotifyUser::Unsubscribe.subscribe(target, type)
      else
        NotifyUser::Unsubscribe.unsubscribe(target,type)
      end
    end

    def self.unsubscribe(target, type, group_id=nil)
      ## creates unsubscribe object if it doesn't already exist
      unless exists?(target_id: target.id, target_type: target.class.base_class.name,
        type: type, group_id: group_id)
        create(target: target, type: type, group_id: group_id)
      end
    end

    def self.subscribe(target, type, group_id=nil)
      #deletes unsubscribe object in essence subscribing a user
      where(target_id: target.id)
      .where(target_type: target.class.base_class.name)
      .where(type: type, group_id: group_id).destroy_all
    end

    ## checks to see if you've unsubscribed from the overall notification type
    ## before checking you've unsubscribed from the specific group_id
    def self.has_unsubscribed_from?(target, type, group_id=nil, channel_name=nil)
      return true if where(target_id: target.id, target_type: target.class.base_class.name).where(type: type).any?
      return true if where(target_id: target.id, target_type: target.class.base_class.name, type: type, group_id: group_id).any? if group_id
      return true if where(target_id: target.id, target_type: target.class.base_class.name, type: channel_name).any? if channel_name
      false
    end

    def self.has_unsubscribed_from(target, type, group_id=nil)
      where(target_id: target.id)
      .where(target_type: target.class.base_class.name)
      .where(type: type, group_id: group_id)
    end

  end
end
