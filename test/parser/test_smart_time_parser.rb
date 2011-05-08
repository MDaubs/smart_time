require 'helper'

module SmartTime
	module Parser
		class TestSmartTimeParser < Test::Unit::TestCase

			def test_parse_with_format
				assert_equal Time.new(2011,5,1,14,30), SmartTimeParser.parse("05/01/2011 2:30PM", {:format=>"%m/%d/%Y %l:%M%p"})
			end

			def test_parse_invalid_with_format
				assert_nil SmartTimeParser.parse("ABCDEFG", {:format=>"%m/%d/%Y"})
			end

		end
	end
end
