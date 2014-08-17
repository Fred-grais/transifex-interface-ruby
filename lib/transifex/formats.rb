module Transifex
  class Formats
    include Transifex::CrudRequests::Fetch    

    def self.fetch
      Formats.new.fetch          
    end 
  end
end