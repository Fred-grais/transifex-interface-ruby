# Add a method add_resource to create a new resource for the project
# Add a method get_resources to fetch all the resources

module Transifex
  class Project    
    include Transifex::CrudRequests::Fetch
    include Transifex::CrudRequests::Update
    include Transifex::CrudRequests::Delete

    attr_accessor :project_slug, :resources

    def initialize(project_slug = nil)
      raise MissingParametersError.new("You must provide a slug for a project") if project_slug.nil?
      @project_slug = project_slug
    end 

    def resources
      @resources ||= Transifex::Resources.new(@project_slug)
    end

    def resource(resource_slug)
      Transifex::Resource.new(@project_slug, resource_slug)
    end

    def languages
      Transifex::ProjectComponents::Languages.new(@project_slug)
    end

    def language(language_code)
      Transifex::ProjectComponents::Language.new(@project_slug, language_code)
    end

    def fetch_with_details
      options = {:details => true}
      fetch(options)      
    end
  end
end