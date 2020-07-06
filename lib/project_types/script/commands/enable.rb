# frozen_string_literal: true

require 'pry'

module Script
  module Commands
    class Enable < ShopifyCli::Command
      options do |parser, flags|
        parser.on('--api_key=APIKEY') { |t| flags[:api_key] = t }
        parser.on('--shop_domain=MYSHOPIFYDOMAIN') { |t| flags[:shop_domain] = t }
        parser.on('--config_props=KEYVALUEPAIRS', Array) do |t|
          flags[:config_props] = Hash[t.map { |s| s.split(':') }]
        end
        parser.on('--config_file=CONFIGFILEPATH') { |t| flags[:config_file] = t }
      end

      def call(args, _name)
        form = Forms::Enable.ask(@ctx, args, options.flags)
        return @ctx.puts(self.class.help) unless form

        project = ScriptProject.current

        Layers::Application::EnableScript.call(
          ctx: @ctx,
          api_key: form.api_key,
          shop_domain: form.shop_domain,
          configuration: acquire_configuration(**options.flags.slice(:config_file, :config_props)),
          extension_point_type: project.extension_point_type,
          title: project.script_name
        )
        @ctx.puts(@ctx.message(
          'script.enable.script_enabled',
          api_key: form.api_key,
          shop_domain: form.shop_domain,
          type: project.extension_point_type.capitalize,
          title: project.script_name
        ))
        @ctx.puts(@ctx.message('script.enable.info'))
      rescue StandardError => e
        UI::ErrorHandler.pretty_print_and_raise(e, failed_op: @ctx.message('script.enable.error.operation_failed'))
      end

      def self.help
        ShopifyCli::Context.message('script.enable.help', ShopifyCli::TOOL_NAME)
      end

      def self.extended_help
        ShopifyCli::Context.message('script.enable.extended_help', ShopifyCli::TOOL_NAME)
      end

      private

      def acquire_configuration(config_file: nil, config_props: nil)
        properties = {}
        properties = JSON.parse(File.read(config_file)) unless config_file.nil?
        properties = properties.merge(config_props) unless config_props.nil?

        configuration = { entries: [] }
        properties.each do |key, value|
          configuration[:entries].push({
            key: key,
            value: value,
          })
        end
        configuration
      end
    end
  end
end
