module Transifex
  class Resource
    include Transifex::CrudRequests::Fetch
    include Transifex::CrudRequests::Update
    include Transifex::CrudRequests::Delete

    attr_accessor :project_slug, :resource_slug

    def initialize(project_slug = nil, resource_slug = nil)
      raise MissingParametersError.new(["project_slug"]) if project_slug.nil?
      raise MissingParametersError.new(["resource_slug"]) if resource_slug.nil?
      @project_slug = project_slug
      @resource_slug = resource_slug
    end

    def self.authors
      [:project]      
    end  

    def fetch_with_details
      options = {:details => true}
      self.fetch(options)      
    end

    def content
      Transifex::ResourceComponents::Content.new(project_slug, resource_slug)
    end

    def statistics
      Transifex::ResourceComponents::Stats.new(project_slug, resource_slug)
    end

    def translation(language_code = nil)      
      Transifex::ResourceComponents::Translation.new(project_slug, resource_slug, language_code)
    end

    def source(key = nil, context = "")          
      Transifex::ResourceComponents::Source.new(project_slug, resource_slug, key, context)
    end
  end
end
