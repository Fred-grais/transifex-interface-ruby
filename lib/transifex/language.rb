module Transifex
  class Language
    include Transifex::CrudRequests::Fetch    

    attr_accessor :language_slug

    def initialize(language_code = nil)
      raise MissingParametersError.new(["language_code"]) if language_code.nil?
      @language_slug = language_code
    end 
        
  end
end