module Transifex
  module ResourceComponents
    class Content
      include Transifex::CrudRequests::Fetch
      include Transifex::CrudRequests::Update

      attr_accessor :project_slug, :resource_slug     

      def initialize(project_slug, resource_slug)
        raise MissingParametersError.new(["project_slug"]) if project_slug.nil?
        raise MissingParametersError.new(["resource_slug"]) if resource_slug.nil?
        @project_slug = project_slug
        @resource_slug = resource_slug
      end
      def self.authors
        [:project, :resource]      
      end
      def fetch_with_file(path_to_file = nil)
        raise MissingParametersError.new(["path_to_file"]) if path_to_file.nil?
        options = {:file => true}
        file_body = fetch(options)         
        write_to_file(path_to_file, file_body)  
      end     

      def update(params = {}, options = {})
        resource_i18n_type = Transifex::Resource.new(@project_slug, @resource_slug).fetch
        raise Transifex::Error.new("You must use the mimetype #{resource_i18n_type["i18n_type"]} to upload a new resource file") if !check_i18n_type_concordance?(resource_i18n_type["i18n_type"], params[:i18n_type]) 
        super
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

        def check_i18n_type_concordance?(resource_i18n_type, param)
          case resource_i18n_type  
          when "YML"            
            param == "YML" || param == "YAML"
          else
            param == resource_i18n_type
          end
        end
    end
  end
end