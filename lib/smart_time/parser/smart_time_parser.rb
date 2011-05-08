module SmartTime
	module Parser
		class SmartTimeParser < SmartParser

			private

			def self._default_formats
				defined?(Time::DATE_FORMATS) ? Time::DATE_FORMATS.values : []
			end

			def self._parse_with_format(value, format)
				Time.strptime(value, format) rescue DateTime.strptime(value, format) rescue nil
			end

		end
	end
end
