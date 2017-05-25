module Transifex
  module ProjectComponents
    class Language
      include Transifex::CrudRequests::Fetch
      include Transifex::CrudRequests::Update
      include Transifex::CrudRequests::Delete

      attr_accessor :project_slug, :language_slug

      def initialize(project_slug = nil, language_code = nil)
        raise MissingParametersError.new(["project_slug"]) if project_slug.nil?
        raise MissingParametersError.new(["language_code"]) if language_code.nil?
        @project_slug = project_slug
        @language_slug = language_code
      end

      def self.authors
        [:project]      
      end

      def fetch_with_details
        options = {:details => true}
        fetch(options)      
      end

      def coordinators
        Transifex::ProjectComponents::LanguageComponents::Coordinators.new(@project_slug, @language_slug)
      end

      def reviewers
        Transifex::ProjectComponents::LanguageComponents::Reviewers.new(@project_slug, @language_slug)
      end

      def translators
        Transifex::ProjectComponents::LanguageComponents::Translators.new(@project_slug, @language_slug)
      end
    end
  end
end