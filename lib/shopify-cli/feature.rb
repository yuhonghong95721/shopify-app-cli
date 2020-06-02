module ShopifyCli
  class Feature
    SECTION = 'features'

    module Set
      def hidden_feature(feature_set: [])
        @feature_hidden = true
        @hidden_feature_set = Array(feature_set).compact
      end

      def hidden?
        enabled = (@hidden_feature_set || []).any? do |feature|
          Feature.enabled?(feature)
        end
        @feature_hidden && !enabled
      end
    end

    class << self
      def enable(feature)
        set(feature, true)
      end

      def disable(feature)
        set(feature, false)
      end

      def enabled?(feature)
        return false if feature.nil?
        ShopifyCli::Config.get_bool(SECTION, feature.to_s)
      end

      private

      def set(feature, value)
        ShopifyCli::Config.set(SECTION, feature.to_s, value)
      end
    end
  end
end
