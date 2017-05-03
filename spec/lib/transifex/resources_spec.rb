require "spec_helper"

describe Transifex::Resources do
  let(:project) { Transifex::Project.new("ruby-client") }

  describe "Instantiation" do
    it "should raise an error if the project_slug is not provided" do
      expect { Transifex::Resources.new }.to raise_error(Transifex::MissingParametersError)
        .with_message("The following attributes are missing: project_slug")
    end
  end

  describe "Fetch" do
    it "should retrieve the resources as an array of hashes, one for each resource" do
      VCR.use_cassette "resources/fetch_as_array" do
        expect(project.resources.fetch).to eq all_project_resources_array
      end
    end

    it "should raise an error if the project doesn't exist" do
      non_existing_project = Transifex::Project.new("not_existing_project")

      VCR.use_cassette "resources/non_existing_project" do
        expect { non_existing_project.resources.fetch }.to raise_error(Transifex::TransifexError)
          .with_message("Not Found")
      end
    end
  end

  describe "Create" do
    it "should raise an error if the required parameters are missing" do
      expect { project.resources.create }.to raise_error(Transifex::MissingParametersError)
        .with_message("The following attributes are missing: slug, name, i18n_type, content")
    end

    it "should create a new resource in the project without using a file" do
      resource_attributes = {slug: "string_resource", name: "without file", i18n_type: "TXT", content: "test"}

      VCR.use_cassette "resources/create_from_string" do
        expect(project.resources.create(resource_attributes)).to eq successful_resource_creation
      end
    end

    it "should create a new resource in the project using a file" do
      resource_attributes = {
        slug: "file_resource",
        name: "with file",
        i18n_type: "YML",
        content: get_yaml_source_trad_file_path("eo")
      }
      options = {trad_from_file: true}

      VCR.use_cassette "resources/create_from_file" do
        expect(project.resources.create(resource_attributes, options)).to eq successful_resource_creation
      end
    end
  end
end
