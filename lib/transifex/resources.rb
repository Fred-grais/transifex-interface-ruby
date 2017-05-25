module Transifex
  class Resources
    include Transifex::CrudRequests::Fetch
    include Transifex::CrudRequests::Create

    CREATE_REQUIRED_PARAMS = [:slug, :name, :i18n_type, :content]

    attr_accessor :project_slug

    def initialize(project_slug = nil)
      raise MissingParametersError.new(["project_slug"]) if project_slug.nil?
      @project_slug = project_slug
    end

    def self.authors
      [:project]      
    end 
  end
end