module ShopifyCli
  class Feature
    SECTION = 'features'

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
