ActiveRecord::Schema.define(:version => 1) do
	create_table :test_models do |t|
		t.datetime :test_datetime_attribute
		t.timestamp :test_timestamp_attribute
		t.time :test_time_attribute
		t.date :test_date_attribute
	end
end
