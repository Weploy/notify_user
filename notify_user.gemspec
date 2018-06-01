# -*- encoding: utf-8 -*-
# stub: notify_user 0.3.2 ruby lib

Gem::Specification.new do |s|
  s.name = "notify_user"
  s.version = "0.3.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Tom Spacek"]
  s.date = "2018-05-23"
  s.description = "Drop-in solution for user notifications. Handles notifying by email, SMS and APNS, plus per-user notification frequency settings and views for checking new notifications."
  s.email = ["ts@papercloud.com.au"]
  s.files = ["MIT-LICENSE", "README.md", "Rakefile", "app/assets/images/notify_user", "app/assets/javascripts/notify_user", "app/assets/javascripts/notify_user/application.js", "app/assets/javascripts/notify_user/notification.js", "app/assets/stylesheets/notify_user", "app/assets/stylesheets/notify_user/notify_user.css", "app/controllers/notify_user/base_notifications_controller.rb", "app/controllers/notify_user/notifications_controller.rb", "app/helpers/notify_user", "app/helpers/notify_user/application_helper.rb", "app/mailers/notify_user", "app/mailers/notify_user/notification_mailer.rb", "app/models/notify_user", "app/models/notify_user/aggregator.rb", "app/models/notify_user/apn_connection.rb", "app/models/notify_user/apns.rb", "app/models/notify_user/base_notification.rb", "app/models/notify_user/channel_presenter.rb", "app/models/notify_user/delivery.rb", "app/models/notify_user/factories", "app/models/notify_user/factories/apns.rb", "app/models/notify_user/factories/base.rb", "app/models/notify_user/factories/gcm.rb", "app/models/notify_user/gcm.rb", "app/models/notify_user/pub_nub.rb", "app/models/notify_user/push.rb", "app/models/notify_user/scheduler.rb", "app/models/notify_user/unsubscribe.rb", "app/models/notify_user/urban_airship.rb", "app/models/notify_user/user_hash.rb", "app/serializers/notify_user/notification_serializer.rb", "app/views/layouts/notify_user", "app/views/layouts/notify_user/application.html.erb", "app/views/notify_user/action_mailer", "app/views/notify_user/action_mailer/aggregate_notification.html.erb", "app/views/notify_user/action_mailer/notification.html.erb", "app/views/notify_user/base_notifications", "app/views/notify_user/base_notifications/index.html.erb", "app/views/notify_user/base_notifications/unsubscribe.html.erb", "app/workers/notify_user", "app/workers/notify_user/delivery_worker.rb", "config/routes.rb", "lib/generators/notify_user", "lib/generators/notify_user/aggr_interval_update", "lib/generators/notify_user/aggr_interval_update/USAGE", "lib/generators/notify_user/aggr_interval_update/aggr_interval_update_generator.rb", "lib/generators/notify_user/aggr_interval_update/templates", "lib/generators/notify_user/aggr_interval_update/templates/add_sent_time_to_notifications.rb", "lib/generators/notify_user/aggr_interval_update/templates/update_unsubscribe.rb", "lib/generators/notify_user/delivery_responses_update", "lib/generators/notify_user/delivery_responses_update/delivery_responses_update_generator.rb", "lib/generators/notify_user/delivery_responses_update/templates", "lib/generators/notify_user/delivery_responses_update/templates/add_responses_to_deliveries.rb", "lib/generators/notify_user/install", "lib/generators/notify_user/install/USAGE", "lib/generators/notify_user/install/install_generator.rb", "lib/generators/notify_user/install/templates", "lib/generators/notify_user/install/templates/add_que.rb", "lib/generators/notify_user/install/templates/create_notify_user_deliveries.rb", "lib/generators/notify_user/install/templates/create_notify_user_notifications.rb", "lib/generators/notify_user/install/templates/create_notify_user_unsubscribes.rb", "lib/generators/notify_user/install/templates/create_notify_user_user_hashes.rb", "lib/generators/notify_user/install/templates/initializer.rb", "lib/generators/notify_user/install/templates/notifications_controller.rb", "lib/generators/notify_user/json_update", "lib/generators/notify_user/json_update/USAGE", "lib/generators/notify_user/json_update/json_update_generator.rb", "lib/generators/notify_user/json_update/templates", "lib/generators/notify_user/json_update/templates/add_json_column_to_notifications.rb", "lib/generators/notify_user/json_update/templates/move_params_to_json.rb", "lib/generators/notify_user/notification", "lib/generators/notify_user/notification/USAGE", "lib/generators/notify_user/notification/notification_generator.rb", "lib/generators/notify_user/notification/templates", "lib/generators/notify_user/notification/templates/email_layout_template.html.erb.erb", "lib/generators/notify_user/notification/templates/email_template.html.erb.erb", "lib/generators/notify_user/notification/templates/mobile_sdk_template.html.erb.erb", "lib/generators/notify_user/notification/templates/notification.rb.erb", "lib/notify_user", "lib/notify_user.rb", "lib/notify_user/channels", "lib/notify_user/channels/action_mailer", "lib/notify_user/channels/action_mailer/action_mailer_channel.rb", "lib/notify_user/channels/apns", "lib/notify_user/channels/apns/apns_channel.rb", "lib/notify_user/channels/gcm", "lib/notify_user/channels/gcm/gcm_channel.rb", "lib/notify_user/channels/pubnub", "lib/notify_user/channels/pubnub/pubnub_channel.rb", "lib/notify_user/engine.rb", "lib/notify_user/railtie.rb", "lib/notify_user/version.rb", "lib/tasks/notify_user.rake", "spec/controllers/notify_user", "spec/controllers/notify_user/notifications_controller_spec.rb", "spec/factories/deliveries.rb", "spec/factories/notify_user_notifications.rb", "spec/factories/users.rb", "spec/fixtures/notify_user", "spec/fixtures/notify_user/notification_mailer", "spec/fixtures/notify_user/notification_mailer/notification_email", "spec/lib/notify_user", "spec/lib/notify_user/channels", "spec/lib/notify_user/channels/action_mailer_channel_spec.rb", "spec/lib/notify_user/channels/apns_channel_spec.rb", "spec/lib/notify_user/channels/gcm_channel_spec.rb", "spec/mailers/notify_user", "spec/mailers/notify_user/notification_mailer_spec.rb", "spec/models/notify_user", "spec/models/notify_user/aggregator_spec.rb", "spec/models/notify_user/apn_connection_spec.rb", "spec/models/notify_user/apns_spec.rb", "spec/models/notify_user/channel_presenter_spec.rb", "spec/models/notify_user/delivery_spec.rb", "spec/models/notify_user/factories", "spec/models/notify_user/factories/apns_spec.rb", "spec/models/notify_user/factories/gcm_spec.rb", "spec/models/notify_user/gcm_spec.rb", "spec/models/notify_user/notification_spec.rb", "spec/models/notify_user/scheduler_spec.rb", "spec/models/notify_user/unsubscribe_spec.rb", "spec/models/notify_user/user_hash_spec.rb", "spec/serializers/notify_user", "spec/serializers/notify_user/notification_serializer_spec.rb", "spec/setup_spec.rb", "spec/spec_helper.rb", "spec/support/database.yml", "spec/support/rails_template.rb", "spec/support/test_apn_connection.rb", "spec/support/test_gcm_connection.rb", "spec/workers/notify_user", "spec/workers/notify_user/delivery_worker_spec.rb"]
  s.homepage = "http://www.papercloud.com.au"
  s.rubygems_version = "2.5.1"
  s.summary = "A Rails engine for user notifications."
  s.test_files = ["spec/spec_helper.rb", "spec/setup_spec.rb", "spec/mailers/notify_user", "spec/mailers/notify_user/notification_mailer_spec.rb", "spec/models/notify_user", "spec/models/notify_user/notification_spec.rb", "spec/models/notify_user/user_hash_spec.rb", "spec/models/notify_user/unsubscribe_spec.rb", "spec/models/notify_user/delivery_spec.rb", "spec/models/notify_user/channel_presenter_spec.rb", "spec/models/notify_user/apns_spec.rb", "spec/models/notify_user/gcm_spec.rb", "spec/models/notify_user/factories", "spec/models/notify_user/factories/apns_spec.rb", "spec/models/notify_user/factories/gcm_spec.rb", "spec/models/notify_user/apn_connection_spec.rb", "spec/models/notify_user/aggregator_spec.rb", "spec/models/notify_user/scheduler_spec.rb", "spec/serializers/notify_user", "spec/serializers/notify_user/notification_serializer_spec.rb", "spec/support/test_gcm_connection.rb", "spec/support/database.yml", "spec/support/rails_template.rb", "spec/support/test_apn_connection.rb", "spec/factories/deliveries.rb", "spec/factories/notify_user_notifications.rb", "spec/factories/users.rb", "spec/lib/notify_user", "spec/lib/notify_user/channels", "spec/lib/notify_user/channels/action_mailer_channel_spec.rb", "spec/lib/notify_user/channels/gcm_channel_spec.rb", "spec/lib/notify_user/channels/apns_channel_spec.rb", "spec/fixtures/notify_user", "spec/fixtures/notify_user/notification_mailer", "spec/fixtures/notify_user/notification_mailer/notification_email", "spec/workers/notify_user", "spec/workers/notify_user/delivery_worker_spec.rb", "spec/controllers/notify_user", "spec/controllers/notify_user/notifications_controller_spec.rb"]

  s.installed_by_version = "2.5.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rails>, [">= 4.0"])
      s.add_runtime_dependency(%q<que>, [">= 0"])
      s.add_runtime_dependency(%q<kaminari>, [">= 0"])
      s.add_runtime_dependency(%q<active_model_serializers>, ["~> 0.10.0"])
      s.add_runtime_dependency(%q<pubnub>, [">= 0"])
      s.add_runtime_dependency(%q<houston>, [">= 0"])
      s.add_runtime_dependency(%q<apnotic>, ["~> 1.3"])
      s.add_runtime_dependency(%q<connection_pool>, [">= 0"])
      s.add_runtime_dependency(%q<gcm>, [">= 0"])
      s.add_runtime_dependency(%q<exponent-server-sdk>, [">= 0"])
      s.add_development_dependency(%q<pg>, [">= 0"])
      s.add_development_dependency(%q<rspec-rails>, [">= 0"])
      s.add_development_dependency(%q<factory_girl_rails>, [">= 0"])
      s.add_development_dependency(%q<capybara>, [">= 0"])
      s.add_development_dependency(%q<awesome_print>, [">= 0"])
      s.add_development_dependency(%q<test_after_commit>, [">= 0"])
      s.add_development_dependency(%q<pry>, [">= 0"])
      s.add_development_dependency(%q<appraisal>, [">= 0"])
      s.add_development_dependency(%q<timecop>, [">= 0"])
      s.add_development_dependency(%q<shoulda-matchers>, ["~> 3.1"])
    else
      s.add_dependency(%q<rails>, [">= 4.0"])
      s.add_dependency(%q<que>, [">= 0"])
      s.add_dependency(%q<kaminari>, [">= 0"])
      s.add_dependency(%q<active_model_serializers>, ["~> 0.10.0"])
      s.add_dependency(%q<pubnub>, [">= 0"])
      s.add_dependency(%q<houston>, [">= 0"])
      s.add_dependency(%q<apnotic>, ["~> 1.3"])
      s.add_dependency(%q<connection_pool>, [">= 0"])
      s.add_dependency(%q<gcm>, [">= 0"])
      s.add_dependency(%q<pg>, [">= 0"])
      s.add_dependency(%q<rspec-rails>, [">= 0"])
      s.add_dependency(%q<factory_girl_rails>, [">= 0"])
      s.add_dependency(%q<capybara>, [">= 0"])
      s.add_dependency(%q<awesome_print>, [">= 0"])
      s.add_dependency(%q<test_after_commit>, [">= 0"])
      s.add_dependency(%q<pry>, [">= 0"])
      s.add_dependency(%q<appraisal>, [">= 0"])
      s.add_dependency(%q<timecop>, [">= 0"])
      s.add_dependency(%q<shoulda-matchers>, ["~> 3.1"])
      s.add_runtime_dependency(%q<exponent-server-sdk>, [">= 0"])

    end
  else
    s.add_dependency(%q<rails>, [">= 4.0"])
    s.add_dependency(%q<que>, [">= 0"])
    s.add_dependency(%q<kaminari>, [">= 0"])
    s.add_dependency(%q<active_model_serializers>, ["~> 0.10.0"])
    s.add_dependency(%q<pubnub>, [">= 0"])
    s.add_dependency(%q<houston>, [">= 0"])
    s.add_dependency(%q<apnotic>, ["~> 1.3"])
    s.add_dependency(%q<connection_pool>, [">= 0"])
    s.add_dependency(%q<gcm>, [">= 0"])
    s.add_dependency(%q<pg>, [">= 0"])
    s.add_dependency(%q<rspec-rails>, [">= 0"])
    s.add_dependency(%q<factory_girl_rails>, [">= 0"])
    s.add_dependency(%q<capybara>, [">= 0"])
    s.add_dependency(%q<awesome_print>, [">= 0"])
    s.add_dependency(%q<test_after_commit>, [">= 0"])
    s.add_dependency(%q<pry>, [">= 0"])
    s.add_dependency(%q<appraisal>, [">= 0"])
    s.add_dependency(%q<timecop>, [">= 0"])
    s.add_dependency(%q<shoulda-matchers>, ["~> 3.1"])
    s.add_runtime_dependency(%q<exponent-server-sdk>, [">= 0"])

  end
end
