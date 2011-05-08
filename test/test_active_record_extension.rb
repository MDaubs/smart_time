require 'helper'

class TestActiveRecordExtension < Test::Unit::TestCase

	def test_smart_time_macro_exists
		assert ActiveRecord::Base.respond_to?(:smart_time), "ActiveRecord::Base doesn't respond to smart_time"
	end

	context "first test model" do

		class TestModelA < ActiveRecord::Base
			def self.table_name() "test_models" end
			smart_time
		end

		def test_smart_time_write_attribute
			SmartTime.expects(:parse).with("05/01/2011", Date, {})
			TestModelA.new.test_date_attribute = "05/01/2011"
		end

	end

	context "second test model" do

		class TestModelB < ActiveRecord::Base
			def self.table_name() "test_models" end
			smart_time :test_time_attribute
			smart_time :test_date_attribute, :format => "%m/%d/%Y"
		end

		def test_smart_time_write_attribute
			SmartTime.expects(:parse).with("05/01/2011", Time, {})
			TestModelB.new.test_time_attribute = "05/01/2011"
			TestModelB.new.test_datetime_attribute = "06/01/2011"
		end

		def test_smart_conversion
			m = TestModelB.new
			m.test_date_attribute = "12/01/2011"
			assert_equal Date.new(2011,12,1), m.test_date_attribute
		end

	end

end
