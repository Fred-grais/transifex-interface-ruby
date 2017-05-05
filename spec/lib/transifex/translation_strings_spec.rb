require "spec_helper"

describe Transifex::ResourceComponents::TranslationComponents::Strings do
  let(:project) { Transifex::Project.new("ruby-client") }
  let(:resource) { project.resource("test") }

  describe "Instantiation" do
    it "should raise an error if the project_slug is not provided" do
      expect { Transifex::ResourceComponents::TranslationComponents::Strings.new }
        .to raise_error(Transifex::MissingParametersError)
        .with_message("The following attributes are missing: project_slug")
    end
  end

  describe "Fetch" do
    describe "#fetch" do
      it "retrieves the translations of all the strings of a resource for a certain language" do
        VCR.use_cassette "translation/fetch_strings" do
          expect(resource.translation("en").strings.fetch).to eq language_strings
        end
      end
    end

    describe "#fetch_with_details" do
      it "retrieves the detailed translations of all the strings of a resource for a certain language" do
        VCR.use_cassette "translation/fetch_with_details_strings" do
          expect(resource.translation("en").strings.fetch_with_details).to eq language_strings_with_details
        end
      end
    end

    it "retrieves the strings of the translation passing the key as an option" do
      options = {key: "test_string"}

      VCR.use_cassette "translation/fetch_with_details_and_key_strings" do
        expect(resource.translation("en").strings.fetch_with_details(options)).to eq language_strings_with_details
      end
    end

    it "returns an empty hash if the specified context doesn't exist" do
      options = {context: "non_existing_context"}

      VCR.use_cassette "translation/fetch_with_details_and_context_strings" do
        expect(resource.translation("en").strings.fetch(options)).to eq []
      end
    end
  end

  describe "Update" do
    it "should raise an error if the key is not provided" do
      VCR.use_cassette "translation/update_without_key_string" do
        expect { resource.translation("en").strings.update(translation: "no key") }
        .to raise_error(Transifex::MissingParametersError)
        .with_message("The following attributes are missing: key")
      end
    end

    it "updates the translation string for the resource for a certain language" do
      params = {key: "test_string", translation: "updated translation"}

      VCR.use_cassette "translation/update_single_translation_strings" do
        expect(resource.translation("en").strings.update(params)).to eq "OK"
        expect(resource.translation("en").string(params[:key]).fetch["translation"]).to eq params[:translation]
      end
    end

    it "updates multiple translation strings" do
      params = [
        {key: "test_string", translation: "multiple translations"},
        {key: "yet_another_string", translation: "yet another translation"}
      ]

      VCR.use_cassette "translation/update_multiple_translation_strings" do
        expect(resource.translation("en").strings.update(params)).to eq "OK"
        expect(resource.translation("en").strings.fetch).to eq multiple_language_strings
      end
    end
  end
end
