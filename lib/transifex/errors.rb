module Transifex
  
  class Error < StandardError
  end

  class MissingParametersError < Error
    def initialize(*missing_attributes)
      super("The following attributes are missing:" + missing_attributes.join(','))
    end
  end

  class ParametersFormatError < Error
    def initialize(parameter, format_expected)
      super("The following parameter: " + parameter.to_s + " must follow the format: " + format_expected)
    end
  end
  
  class TransifexError < Error
    attr_reader :request_url, :code, :details
    def initialize(request_url, code, details)
      @request_url, @code, @details = request_url, code, details
      super(details) if details
    end
  end
end