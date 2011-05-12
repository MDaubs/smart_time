module SmartTime
  module Parser
    class SmartDateParser < SmartParser

      private

      def self._default_formats
        defined?(Date::DATE_FORMATS) ? Date::DATE_FORMATS.values : []
      end

      def self._parse_with_format(value, format)
        Date.strptime(value, format) rescue nil
      end

    end
  end
end
