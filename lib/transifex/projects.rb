module Transifex
  class Projects
    include Transifex::CrudRequests::Fetch
    include Transifex::CrudRequests::Create

    CREATE_REQUIRED_PARAMS = [:slug, :name, :description, :source_language_code, :repository_url, :private]

    def self.fetch
      Transifex::Projects.new.fetch      
    end

    def fetch_with_details
      options = {:details => true}
      fetch(options)      
    end

    def self.create(params = {}, options = {})
      Projects.new.create(params, options)
      Transifex::Project.new(params[:slug])
    end
  end
end