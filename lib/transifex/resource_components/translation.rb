module Transifex
  module ResourceComponents
    class Translation
      include Transifex::CrudRequests::Fetch
      include Transifex::CrudRequests::Update

      attr_accessor :project_slug, :resource_slug, :translation_slug

      def initialize(project_slug = nil, resource_slug = nil, translation_slug = nil)
        raise MissingParametersError.new(["project_slug"]) if project_slug.nil?
        raise MissingParametersError.new(["resource_slug"]) if resource_slug.nil?
        raise MissingParametersError.new(["translation_slug"]) if translation_slug.nil?
        @project_slug = project_slug
        @resource_slug = resource_slug
        @translation_slug = translation_slug
      end

      def self.authors
        [:project, :resource]      
      end 

      def fetch(options = {})
        super
      end

      def fetch_with_file(options = {})
        raise MissingParametersError.new(["path_to_file"]) if options[:path_to_file].nil?
        path_to_file = options.delete(:path_to_file)
        options[:file] = true
        file_body = fetch(options)         
        write_to_file(path_to_file, file_body)  
      end 

      def strings
        Transifex::ResourceComponents::TranslationComponents::Strings.new(@project_slug, @resource_slug, @translation_slug)  
      end

      def string(key = nil , context = "")
        raise MissingParametersError.new(["key"]) if key.nil?
        raise MissingParametersError.new(["context"]) if context.nil?        
        Transifex::ResourceComponents::TranslationComponents::String.new(@project_slug, @resource_slug, @translation_slug, key, context)  
      end

      private 

        def write_to_file(path_to_file, content)          
          case File.extname(path_to_file)
          when ".yml"
            # Needed to correct carriage return problems when writing the Api response in the file
            d = YAML::load(content)
            File.open(path_to_file, "w") { |file| file.write d.to_yaml }    
          else
            File.open(path_to_file, "w") { |file| file.write content }
          end
        end

    end
  end
end