module Transifex
  module CrudRequests
    class << self      
      def generate_url(object, params = {})
        class_name_string = object.class.name.split("::").last.downcase.to_s
        url = ""
        if object.class.respond_to?(:authors)
          object.class.authors.map{|author| url += "/" + author.to_s + "/" + object.instance_variable_get("@" + author.to_s + "_slug")}                      
        end          
        url += "/" + class_name_string
        url += "/" + object.instance_variable_get("@" + class_name_string + "_slug") if object.instance_variable_defined?("@" + class_name_string + "_slug")
        params.each do |param| 
          url = add_param(url, param[0], param[1])
        end
        url
      end

      def add_param(url, param_name, param_value)
        uri = URI(url)
        params = URI.decode_www_form(uri.query || "") << [param_name, param_value]
        uri.query = URI.encode_www_form(params)
        uri.to_s
      end
    end

    module Fetch
      module InstanceMethods
        def fetch(options = {})
          url = CrudRequests.generate_url(self, options)  
          Transifex.query_api(:get, url)
        end
      end
      def self.included(receiver)
        receiver.send(:include, InstanceMethods)                 
      end
    end
    module Create
      module InstanceMethods
        def create(params = {}, options = {})
          missing_keys = self.class::CREATE_REQUIRED_PARAMS - params.keys
          raise MissingParametersError.new(missing_keys) unless (missing_keys == [:repository_url] || missing_keys == [:private]) || missing_keys.empty?
          if params[:repository_url] && !params[:repository_url].empty? && params[:repository_url].match(/^(http|https|ftp):\/\/[a-zA-Z]+\.[a-zA-Z]+\.[a-zA-Z]+/).nil?
            raise ParametersFormatError.new(:repository_url, "http|https|ftp://x.x.x") 
          end
          unless options[:trad_from_file].nil?
            if params[:i18n_type] == "YAML"
              params[:content] = YAML::load_file(params[:content]).to_yaml
            else
              file = File.open(params[:content], "rb")
              params[:content] = file.read
              file.close
            end
          end
          url = CrudRequests.generate_url(self)
          Transifex.query_api(:post, url, params)
        end
      end    
       
      def self.included(receiver)
        receiver.send(:include, InstanceMethods)                 
      end
    end    
    module Update
      module InstanceMethods
        def update(params = {}, options = {})      
          if params.is_a?(Hash) && params[:i18n_type] && params[:i18n_type] != "TXT"
            case params[:i18n_type]
            when "YML"
              params[:content] = YAML::load_file(params[:content]).to_yaml
            when "KEYVALUEJSON"
              params[:content] = params[:content].to_json
            else
              file = File.open(params[:content], "rb")
              params[:content] = file.read
              file.close
            end

            # Deal with accents
            params[:content] = params[:content].force_encoding("UTF-8")
          end

          url = CrudRequests.generate_url(self)

          Transifex.query_api(:put, url, params)
        end
      end

      def self.included(receiver)
        receiver.send(:include, InstanceMethods)                 
      end
    end
    module Delete
      module InstanceMethods
        def delete(params = {}, options = {})          
          url = CrudRequests.generate_url(self)
          Transifex.query_api(:delete, url, params)
        end
      end    
       
      def self.included(receiver)
        receiver.send(:include, InstanceMethods)                 
      end
    end    
  end  
end
