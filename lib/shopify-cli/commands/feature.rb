require 'shopify_cli'

module ShopifyCli
  module Commands
    class Feature < ShopifyCli::Command
      hidden_command(feature_set: :debug)

      subcommand :Enable, 'enable'
      subcommand :Disable, 'disable'

      def call(*)
        @ctx.puts(self.class.help)
      end

      def self.help
        ShopifyCli::Context.message('core.feature.help', ShopifyCli::TOOL_NAME)
      end

      class Enable < ShopifyCli::SubCommand
        def call(args, _name)
          feature_name = args.shift
          if ShopifyCli::Feature.enabled?(feature_name)
            @ctx.puts(@ctx.message('core.feature.already_enabled', feature_name))
          else
            ShopifyCli::Feature.enable(feature_name)
            @ctx.puts(@ctx.message('core.feature.enabled', feature_name))
          end
        end
      end

      class Disable < ShopifyCli::SubCommand
        def call(args, _name)
          feature_name = args.shift
          if ShopifyCli::Feature.enabled?(feature_name)
            ShopifyCli::Feature.disable(feature_name)
            @ctx.puts(@ctx.message('core.feature.disabled', feature_name))
          else
            @ctx.puts(@ctx.message('core.feature.already_disabled', feature_name))
          end
        end
      end
    end
  end
end
