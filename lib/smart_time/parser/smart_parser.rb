module SmartTime
	module Parser
		class SmartParser

			def self.parse(value, options={})
				return _parse_with_format(value, options[:format]) if options[:format].is_a?(String)
				_default_formats.each do |format|
					result = _parse_with_format(value, format) if format.is_a?(String)
					return result if result
				end
				nil
			end

		end
	end
end
