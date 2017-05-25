module Transifex
  module ResourceComponents
    class Source
      include Transifex::CrudRequests::Fetch
      include Transifex::CrudRequests::Update
      include Transifex::ResourceComponents::TranslationComponents::Utilities 

      attr_accessor :project_slug, :resource_slug, :source_slug     

      def initialize(project_slug = nil, resource_slug = nil, translation_key = nil, translation_context = "")
        raise MissingParametersError.new(["project_slug"]) if project_slug.nil?
        raise MissingParametersError.new(["resource_slug"]) if resource_slug.nil?
        raise MissingParametersError.new(["translation_key"]) if translation_key.nil?
        @project_slug = project_slug
        @resource_slug = resource_slug
        @source_slug = compute_source_entity_hash(translation_key, translation_context)
      end
      def self.authors
        [:project, :resource]      
      end
    end
  end
end