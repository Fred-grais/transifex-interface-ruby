module Transifex
  module ProjectComponents
    module LanguageComponents
      class Translators
        include Transifex::CrudRequests::Fetch
        include Transifex::CrudRequests::Update

        attr_accessor :project_slug, :language_slug

        def initialize(project_slug = nil, language_code = nil)
          raise MissingParametersError.new(["project_slug"]) if project_slug.nil?
          raise MissingParametersError.new(["language_code"]) if language_code.nil?
          @project_slug = project_slug
          @language_slug = language_code
        end

        def self.parents
          [:project, :language]
        end
              
        def update(translators_list = {}, options = {})
          # Transifex needs coordinators list to be passed also when updating reviewers list. Strange
          # Fetch the current coordinators list and add it to the params as a workaround.
          fetched_language_infos = Transifex::Project.new(@project_slug).language(@language_slug).fetch
          params = {}
          params[:coordinators] = fetched_language_infos["coordinators"]          
          params[:translators] = translators_list
          super(params, options)
        end
      end
    end
  end
end