require "spec_helper"

describe Transifex::ProjectComponents::LanguageComponents::Translators do
  let(:project) { Transifex::Project.new("ruby-client") }

  describe "Instantiation" do
    it "raises an error when the project_slug is not provided" do
      expect { Transifex::ProjectComponents::LanguageComponents::Translators.new }
        .to raise_error(Transifex::MissingParametersError)
        .with_message("The following attributes are missing: project_slug")
    end
  end

  describe "Fetch" do
    it "retrieves the language translators" do
      VCR.use_cassette "project/language/fetch_translators" do
        expect(project.language("en").translators.fetch).to eq({"translators" => []})
      end
    end
  end

  describe "Update" do
    it "updates the translators list" do
      VCR.use_cassette "project/language/update_translators" do
        expect(project.language("en").translators.update(["mupo"])).to eq "OK"
        expect(project.language("en").translators.fetch).to eq({"translators" => ["mupo"]})
      end
    end

    it "raises an error if the translator doesn't exist" do
      VCR.use_cassette "project/language/update_non_existing_translator" do
        expect { project.language("en").translators.update(["not_existing_translator"]) }
          .to raise_error(Transifex::TransifexError)
          .with_message("Users not_existing_translator do not exist.")
      end
    end
  end
end
