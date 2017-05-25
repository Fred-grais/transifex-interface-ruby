module Transifex
  module ProjectComponents
    module LanguageComponents
      class Coordinators
        include Transifex::CrudRequests::Fetch
        include Transifex::CrudRequests::Update

        attr_accessor :project_slug, :language_slug

        def initialize(project_slug = nil, language_code = nil)
          raise MissingParametersError.new(["project_slug"]) if project_slug.nil?
          raise MissingParametersError.new(["language_code"]) if language_code.nil?
          @project_slug = project_slug
          @language_slug = language_code
        end

        def self.authors
          [:project, :language]
        end

        def update(coordinators = [], options = {})
          super({"coordinators" => coordinators}, options)
        end
      end
    end
  end
end
