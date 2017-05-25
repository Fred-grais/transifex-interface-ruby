module Transifex
  module ResourceComponents
    module TranslationComponents             
      class Strings 
        include Transifex::CrudRequests::Fetch        
        include Transifex::CrudRequests::Update  
        include Utilities 
        attr_accessor :project_slug, :resource_slug, :translation_slug

        def initialize(project_slug = nil, resource_slug = nil, translation_slug = nil)
          raise MissingParametersError.new(["project_slug"]) if project_slug.nil?
          raise MissingParametersError.new(["resource_slug"]) if resource_slug.nil?
          raise MissingParametersError.new(["translation_slug"]) if translation_slug.nil?
          @project_slug = project_slug
          @resource_slug = resource_slug
          @translation_slug = translation_slug
        end  

        def fetch_with_details(options = {})
          options[:details] = true
          self.fetch(options)      
        end

        def self.authors
          [:project, :resource, :translation]            
        end  

        def update(params)
          params = [params] unless params.is_a?(Array)
          params.each do |param|
            raise MissingParametersError.new(["key"]) unless param.key?(:key)
            param[:source_entity_hash] = compute_source_entity_hash(param[:key], param[:context])
          end
          super
        end 
      end
    end
  end
end