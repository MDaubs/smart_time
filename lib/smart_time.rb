module SmartTime
  extend ActiveSupport::Autoload

  module Parser
    extend ActiveSupport::Autoload

    autoload :SmartParser
    autoload :SmartDateParser
    autoload :SmartTimeParser
    autoload :RubyDateParser
    autoload :RubyTimeParser
  end

  autoload :ActiveRecordExtension

  PARSERS_BY_CLASS = {
    Date => [Parser::SmartDateParser, Parser::RubyDateParser],
    Time => [Parser::SmartTimeParser, Parser::RubyTimeParser]
  }

  def self.can_parse?(klass)
    PARSERS_BY_CLASS.include?(klass)
  end

  def self.parse(value, klass, options)
    PARSERS_BY_CLASS[klass].each do |parser|
      result = parser.parse(value, options)
      return result if result
    end
  end

  ActiveRecord::Base.send(:include, SmartTime::ActiveRecordExtension)

end
