module Transifex
  class Languages
    include Transifex::CrudRequests::Fetch  

    def self.fetch
      Languages.new.fetch          
    end    
  end
end