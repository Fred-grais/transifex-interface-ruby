require "spec_helper"

describe Transifex::ResourceComponents::Translation do
  let(:project) { Transifex::Project.new("ruby-client") }
  let(:resource) { project.resource("test") }

  describe "Instantiation" do
    it "should raise an error if the project_slug is missing" do
      expect { Transifex::ResourceComponents::Translation.new }.to raise_error(Transifex::MissingParametersError)
        .with_message("The following attributes are missing: project_slug")
    end
  end

  describe "Fetch" do
    describe "#fetch" do
      it "should raise an error if no language code is provided" do
        VCR.use_cassette "resource/fetch_without_language_code_translations" do
          expect { resource.translation.fetch }.to raise_error(Transifex::MissingParametersError)
            .with_message("The following attributes are missing: translation_slug")
        end
      end

      it "should retrieve a resource translation content as a hash" do
        VCR.use_cassette "resource/fetch_translations" do
          expect(resource.translation("en").fetch).to eq translation_content
        end
      end
    end

    describe "#fetch_with_file" do
      it "should retrieve the translation content as a file with default mode" do
        path_to_file = "translations.yml"
        options = {path_to_file: path_to_file}

        VCR.use_cassette "resource/fetch_with_file_translations" do
          resource.translation("en").fetch_with_file(options)

          expect(File.exist?(path_to_file)).to be true
          expect(File.read(path_to_file)).to eq file_translation_content
        end
      end

      it "should retrieve the translation content as a file with a specific mode" do
        path_to_file = "translations.yml"
        options = {path_to_file: path_to_file, mode: "translator"}

        VCR.use_cassette "resource/fetch_with_file_and_mode_translations" do
          resource.translation("en").fetch_with_file(options)

          expect(File.exist?(path_to_file)).to be true
          expect(File.read(path_to_file)).to eq file_translation_content_with_mode
        end
      end
    end
  end

  describe "Update" do
    it "sould raise an error if try to update source language" do
      options = {i18n_type: "YAML", content: get_yaml_source_trad_file_path("eo")}

      VCR.use_cassette "resource/update_source_language" do
        expect { resource.translation("eo").update(options) }.to raise_error(Transifex::TransifexError)
          .with_message("Cannot update the source language")
      end
    end

    it "should update the resource translation" do
      options = {i18n_type: "YAML", content: get_yaml_source_trad_file_path("en")}

      VCR.use_cassette "resource/update_translation_for_language" do
        expect(resource.translation("en").update(options)).to eq updated_translations
      end
    end
  end
end
