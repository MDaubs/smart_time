require 'helper'

module SmartTime
  module Parser
    class TestSmartDateParser < Test::Unit::TestCase

      def test_parse_with_format
        assert_equal Date.new(2011,5,1), SmartDateParser.parse("05/01/2011", {:format=>"%m/%d/%Y"})
      end
      
      def test_parse_invalid_with_format
        assert_nil SmartDateParser.parse("ABCDEFG", {:format=>"%m/%d/%Y"})
      end

      def test_parse_with_default_formats
        assert_equal Date.new(2011,1,5), SmartDateParser.parse("2011-01-05")
      end

      def test_parse_invalid_with_default_formats
        assert_nil SmartDateParser.parse("ABCDEFG")
      end

    end
  end
end
