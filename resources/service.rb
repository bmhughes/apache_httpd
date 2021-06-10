#
# Cookbook:: apache_httpd
# Resource:: service
#
# Copyright:: 2021, Ben Hughes, All Rights Reserved.

unified_mode true

include ApacheHttpd::Cookbook::GeneralHelpers

property :service_name, String,
          default: lazy { default_apache_service_name },
          description: 'The service name to perform actions upon'

property :config_test, [true, false],
          default: true,
          description: 'Perform configuration file test before performing service action'

property :config_test_fail_action, Symbol,
          equal_to: %i(raise log),
          default: :raise,
          description: 'Action to perform upon configuration test failure.'

action_class do
  def perform_config_test
    shell_out!('/usr/sbin/apachectl -t')
  end

  def do_service_action(resource_action)
    with_run_context(:root) do
      if %i(start restart reload).include?(resource_action)
        begin
          if new_resource.config_test
            perform_config_test
            Chef::Log.info("Configuration test passed, creating #{new_resource.service_name} #{new_resource.declared_type} resource with action #{resource_action}")
          else
            Chef::Log.info("Configuration test disabled, creating #{new_resource.service_name} #{new_resource.declared_type} resource with action #{resource_action}")
          end

          declare_resource(:service, new_resource.service_name) { delayed_action(resource_action) }
        rescue Mixlib::ShellOut::ShellCommandFailed
          if new_resource.config_test_fail_action.eql?(:log)
            Chef::Log.error("Configuration test failed, #{new_resource.service_name} #{resource_action} action aborted!\n\n"\
                            "Error\n-----\n#{cmd.stderr}")
          else
            raise "Configuration test failed, #{new_resource.service_name} #{resource_action} action aborted!\n\n"\
                  "Error\n-----\nAction: #{resource_action}\n#{cmd.stderr}"
          end
        end
      else
        declare_resource(:service, new_resource.service_name) { action(resource_action) }
      end
    end
  end
end

%i(start stop restart reload enable disable).each do |action_type|
  send(:action, action_type) { do_service_action(action) }
end

action :test do
  converge_by('Performing configuration test') { perform_config_test }
end
