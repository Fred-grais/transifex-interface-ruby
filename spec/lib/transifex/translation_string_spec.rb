require "spec_helper"

describe Transifex::ResourceComponents::TranslationComponents::String do
  let(:project) { Transifex::Project.new("ruby-client") }
  let(:resource) { project.resource("test") }

  describe "Instantiation" do
    it "should raise an error if the translation key is not provided" do
      expect { Transifex::ResourceComponents::TranslationComponents::String.new }
        .to raise_error(Transifex::MissingParametersError)
        .with_message("The following attributes are missing: translation_key")
    end
  end

  describe "Fetch" do
    it "should raise an error if the key is not provided" do
      expect { resource.translation("en").string.fetch }
        .to raise_error(Transifex::MissingParametersError)
        .with_message("The following attributes are missing: key")
    end

    it "retrieve the details of the string" do
      VCR.use_cassette "translation/fetch_string" do
        expect(resource.translation("en").string("test_string").fetch).to eq string_details
      end
    end
  end

  describe "Update" do
    it "update the specified translation string" do
      params = {reviewed: true, translation: "translated test string"}

      VCR.use_cassette "translation/update_string" do
        expect(resource.translation("en").string("test_string").update(params)).to eq "OK"
        expect(resource.translation("en").string("test_string").fetch["translation"]).to eq params[:translation]
      end
    end
  end
end
