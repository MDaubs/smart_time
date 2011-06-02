require 'helper'

class TestSmartTime < Test::Unit::TestCase

  def test_active_record_extension_loaded
    assert ActiveRecord::Base.included_modules.include?(SmartTime::ActiveRecordExtension)
  end

  def test_can_parse
    assert SmartTime.can_parse?(Date)
    assert SmartTime.can_parse?(Time)
    assert !SmartTime.can_parse?(String)
    assert !SmartTime.can_parse?(Class)
  end

  def test_parse_with_smart_date_parser
    SmartTime::Parser::SmartDateParser.expects(:parse).with("05/01/2011", {:format => "ABCDEFG"}).returns("ZZZ")
    assert_equal "ZZZ", SmartTime.parse("05/01/2011", Date, {:format => "ABCDEFG"})
  end

  def test_parse_with_ruby_date_parser
    SmartTime::Parser::SmartDateParser.expects(:parse).with("05/01/2011", {:format => "ABCDEFG"}).returns(nil)
    SmartTime::Parser::RubyDateParser.expects(:parse).with("05/01/2011", {:format => "ABCDEFG"}).returns("ZZZ")
    assert_equal "ZZZ", SmartTime.parse("05/01/2011", Date, {:format => "ABCDEFG"})
  end

  def test_parse_date_time_returns_same_date_time
    time_now = Time.now
    assert_equal time_now, SmartTime.parse(time_now, Date, {})
  end

end
