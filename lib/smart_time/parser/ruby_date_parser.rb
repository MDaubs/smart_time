module SmartTime
	module Parser
		class RubyDateParser

			def self.parse(value, options)
				Date.parse(value) rescue nil
			end

		end
	end
end

