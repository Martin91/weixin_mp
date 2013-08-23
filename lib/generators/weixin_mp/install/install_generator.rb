module WeixinMp
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("../templates", __FILE__)

      def decorate_messages_controller
        copy_file "app/controllers/weixin_mp/messages_controller_decorator.rb",
                  "app/controllers/weixin_mp/messages_controller_decorator.rb"
      end

      def enable_decorators
        application <<-APP

    config.to_prepare do
      # Load application's model / class decorators
      Dir.glob(File.join(File.dirname(__FILE__), "../app/**/*_decorator*.rb")) do |c|
        Rails.configuration.cache_classes ? require(c) : load(c)
      end
    end
        APP
      end

      def set_weixin_token
        initializer 'weixin_mp.rb' do
          "Rails.configuration.weixin_token = 'Set your token here'\n"
        end
      end

      def notify_about_routes
          insert_into_file File.join('config', 'routes.rb'), :after => "Application.routes.draw do\n" do
            %Q{
  # This line mounts WeixinMp's routes at the "/weixin" of your application.
  mount WeixinMp::Engine, :at => '/weixin'

            }
          end

          unless options[:quiet]
            puts "*" * 50
            puts "We added the following line to your application's config/routes.rb file:"
            puts " "
            puts "    mount WeixinMp::Engine, :at => '/weixin'"
          end
        end
    end
  end
end