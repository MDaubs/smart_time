module SmartTime
  module Parser
    class RubyTimeParser

      def self.parse(value, options)
        Time.zone.parse(value) rescue nil
      end

    end
  end
end
