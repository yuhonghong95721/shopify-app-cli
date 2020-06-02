require 'shopify_cli'

module ShopifyCli
  module Commands
    class Config < ShopifyCli::Command
      hidden_feature(feature_set: :debug)

      subcommand :Feature, 'feature'

      def call(*)
        @ctx.puts(self.class.help)
      end

      def self.help
        ShopifyCli::Context.message('core.config.help', ShopifyCli::TOOL_NAME)
      end

      class Feature < ShopifyCli::SubCommand
        def call(args, _name)
          feature_name = args.shift
          if ShopifyCli::Feature.enabled?(feature_name)
            ShopifyCli::Feature.disable(feature_name)
            @ctx.puts(@ctx.message('core.config.feature.disabled', feature_name))
          else
            ShopifyCli::Feature.enable(feature_name)
            @ctx.puts(@ctx.message('core.config.feature.enabled', feature_name))
          end
        end
      end
    end
  end
end
