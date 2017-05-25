module Transifex
  module ResourceComponents
    class Stats
      include Transifex::CrudRequests::Fetch

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

      def fetch(language_code = nil)
        instance_variable_set(:@stats_slug, language_code) unless language_code.nil?
        super()
      end
    end
  end
end