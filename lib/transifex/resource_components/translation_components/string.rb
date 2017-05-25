module Transifex
  module ResourceComponents
    module TranslationComponents             
      class String
        include Transifex::CrudRequests::Fetch        
        include Transifex::CrudRequests::Update        
        include Utilities 

        attr_accessor :project_slug, :resource_slug, :translation_slug, :string_slug

        def initialize(project_slug = nil, resource_slug = nil, translation_slug = nil, translation_key = nil, translation_context = nil)
          raise MissingParametersError.new(["translation_key"]) if translation_key.nil?
          raise MissingParametersError.new(["translation_context"]) if translation_context.nil?
          raise MissingParametersError.new(["project_slug"]) if project_slug.nil?
          raise MissingParametersError.new(["resource_slug"]) if resource_slug.nil?
          raise MissingParametersError.new(["translation_slug"]) if translation_slug.nil?
          @project_slug = project_slug
          @resource_slug = resource_slug
          @translation_slug = translation_slug
          @string_slug = compute_source_entity_hash(translation_key, translation_context)
        end

        def self.authors
          [:project, :resource, :translation]            
        end
      end
    end
  end
end