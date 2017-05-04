require_relative "../../spec_helper"

describe Transifex::ResourceComponents::Content do
  let(:project) { Transifex::Project.new("ruby-client") }
  let(:resource) { project.resource("test") }

  describe "Instantiation" do
    it "should raise an error when no parameters given" do
      expect{ Transifex::ResourceComponents::Content.new }.to raise_error(ArgumentError)
    end
  end

  describe "Fetch" do
    it "should retrieve the resource content as a hash" do
      VCR.use_cassette "resource/fetch_content_as_hash" do
        expect(resource.content.fetch).to eq(
          {"content" => %Q{eo:\n  test_string: "test string"\n}, "mimetype" => "text/plain"}
        )
      end
    end

    it "should retrieve the resource content as a file" do
      VCR.use_cassette "resource/fetch_content_as_file" do
        resource.content.fetch_with_file("fetched.yml")
      end

      expect(File.exist?("fetched.yml")).to be true
    end
  end

  describe "Update" do
    it "should update a resource using a file" do
      VCR.use_cassette "resource/update_content_yml" do
        expect { resource.content.update(i18n_type: "YAML", content: get_yaml_source_trad_file_path('eo')) }.to_not raise_error
      end
    end

    it "should raise an error if the mime type of the resource to be updated is different than the one defined in the project for the resource" do
      VCR.use_cassette "resource/update_content_with_wrong_mimetype" do
        expect { resource.content.update(i18n_type: "TXT", content: "") }.to raise_error(Transifex::Error)
          .with_message("You must use the mimetype YML to upload a new resource file")
      end
    end
  end
end
