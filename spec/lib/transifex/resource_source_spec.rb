require "spec_helper"

describe Transifex::ResourceComponents::Source do
  let(:project) { Transifex::Project.new("ruby-client") }
  let(:resource) { project.resource("json") }

  describe "Instantiation" do
    it "should raise an error if the project_slug is not provided" do
      expect{ Transifex::ResourceComponents::Source.new }.to raise_error(Transifex::MissingParametersError)
        .with_message("The following attributes are missing: project_slug")
    end
  end

  describe "Fetch" do
    it "should retrieve the meta-data of a resource source string" do
      VCR.use_cassette "resource/fetch_source_string_metadata" do
        expect(resource.source("content.update_string").fetch).to eq resource_source_string_metadata
      end
    end
  end

  describe "Update" do
    it "should update the meta-data of a resource source string" do
      params = {comment: "my comment", character_limit: 140, tags: ["tag1", "tag2"]}

      VCR.use_cassette "resource/update_source_string_metadata" do
        expect(resource.source("content.update_string").update(params)).to eq "OK"
        expect(resource.source("content.update_string").fetch).to eq updated_resource_source_string_metadata
      end
    end
  end
end
