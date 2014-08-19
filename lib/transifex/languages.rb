module Transifex
  class Languages
    include Transifex::CrudRequests::Fetch  

    def self.fetch(language_code = nil)
      if language_code.nil?
        Languages.new.fetch
      else
        Transifex::Language.new(language_code).fetch
      end                
    end    
  end
end