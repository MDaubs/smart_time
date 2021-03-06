require 'helper'

class TestActiveRecordExtension < Test::Unit::TestCase

  def test_smart_time_macro_exists
    assert ActiveRecord::Base.respond_to?(:smart_time), "ActiveRecord::Base doesn't respond to smart_time"
  end

  context "first test model" do

    class TestModelA < ActiveRecord::Base
      set_table_name "test_models"
      smart_time
    end

    def test_smart_time_write_attribute
      SmartTime.expects(:parse).with("05/01/2011", Date, {})
      TestModelA.new.test_date_attribute = "05/01/2011"
    end

    def test_invalid_format_sets_value_to_nil
      model = TestModelA.new
      model.test_date_attribute = "NOTAVALIDDATETIME"
      assert_nil model.test_date_attribute
    end

    def test_smart_conversion_of_date
      model = TestModelA.new
      model.test_date_attribute = "05/01/2011"
      assert_equal Date.new(2011,5,1), model.test_date_attribute
    end

  end

  context "second test model" do

    class TestModelB < ActiveRecord::Base
      set_table_name "test_models"
      smart_time :test_time_attribute
      smart_time :test_date_attribute, :format => "%m/%d/%Y"
    end

    def test_smart_time_write_attribute
      SmartTime.expects(:parse).with("05/01/2011", Time, {})
      TestModelB.new.test_time_attribute = "05/01/2011"
      TestModelB.new.test_datetime_attribute = "06/01/2011"
    end

    def test_smart_conversion_of_date
      m = TestModelB.new
      m.test_date_attribute = "12/01/2011"
      assert_equal Date.new(2011,12,1), m.test_date_attribute
    end

  end

end
