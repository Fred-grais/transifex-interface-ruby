require "spec_helper"

describe Transifex::Projects do

  describe "Create" do
    it "should raise an error if parameters are missing" do
      expect { Transifex::Projects.create(slug: "private-ruby-client") }
        .to raise_error(Transifex::MissingParametersError)
        .with_message("The following attributes are missing: name, description, source_language_code, repository_url, private")
    end

    it "creates a private project" do
      params = {
        slug: "private-ruby-client",
        name: "Private Ruby Client",
        description: "Private Ruby Client",
        source_language_code: "eo",
        private: true
      }

      VCR.use_cassette "projects/create_private_project" do
        project = Transifex::Projects.create(params)

        expect(project.project_slug).to eq(params[:slug])
        expect(Transifex::Project.new(params[:slug]).fetch).to eq(private_project_info)
      end
    end

    it "raises an error if a project with the same slug already exists" do
      params = {
        slug: "private-ruby-client",
        name: "Private Ruby Client",
        description: "Private Ruby Client",
        source_language_code: "eo",
        private: true
      }

      VCR.use_cassette "projects/create_used_slug_project" do
        expect { Transifex::Projects.create(params) }.to raise_error(Transifex::TransifexError)
          .with_message("[u\"[('slug', [u'Project with this Slug already exists.'])]\"]")
      end
    end

    it "creates a public project" do
      params = {
        slug: "public-ruby-client",
        name: "Public Ruby Client",
        description: "Public Ruby Client",
        source_language_code: "it",
        repository_url: "http://valid.url.it"
      }

      VCR.use_cassette "projects/create_public_project" do
        project = Transifex::Projects.create(params)

        expect(project.project_slug).to eq(params[:slug])
        expect(Transifex::Project.new(params[:slug]).fetch).to eq(public_project_info)
      end
    end

    it "should raise an error if repository_url is not matching the requested format" do
      params = {
        slug: "public-ruby-client",
        name: "Public Ruby Client",
        description: "Public Ruby Client",
        source_language_code: "it",
        repository_url: "http://not-valid.url"
      }

      expect { Transifex::Projects.create(params) }
        .to raise_error(Transifex::ParametersFormatError)
        .with_message("The following parameter: repository_url must follow the format: http|https|ftp://x.x.x")
    end
  end

  describe "Fetch" do
    it "retrieves the projects as an array of hashes, one for each project" do
      VCR.use_cassette "projects/fetch_projects" do
        expect(Transifex::Projects.fetch).to eq(all_projects_info)
      end
    end
  end
end
