module SmartTime
	module ActiveRecordExtension
		extend ActiveSupport::Concern

		included do
		end

		module ClassMethods

			def smart_time_attributes
				@smart_time_attributes
			end

			def smart_time(*args)
				options = args.extract_options!
				new_attributes = args
				first_call = !defined?(@smart_time_attributes)
				@smart_time_attributes ||= {}

				# If no attributes were specified then add all parsable attributes
				if new_attributes.empty?
					columns.each do |column|
						@smart_time_attributes[column.name.to_sym] = options if SmartTime.can_parse?(column.klass)
					end
				else
					new_attributes.each do |attribute|
						@smart_time_attributes[attribute.to_sym] = options
					end
				end

				# Override attribute write method
				unless first_call
					self.class_eval do
						def write_attribute(attr_name, value)
							if self.class.smart_time_attributes[attr_name.to_sym]
								value = SmartTime.parse(value, column_for_attribute(attr_name).klass, self.class.smart_time_attributes[attr_name.to_sym])
							end
							super(attr_name, value)
						end
					end
				end

			end

		end

		module InstanceMethods
		end

	end
end
