require "spec_helper"

describe Transifex::ProjectComponents::Languages do
  let(:project) { Transifex::Project.new("ruby-client") }

  describe "Instantiation" do
    it "should raise an error if the project_slug is not provided" do
      expect { Transifex::ProjectComponents::Languages.new }
        .to raise_error(Transifex::MissingParametersError)
        .with_message("The following attributes are missing: project_slug")
    end
  end

  describe "Fetch" do
    it "should retrieve the information for all languages of the project" do
      VCR.use_cassette "project/components/fetch_languages" do
        expect(project.languages.fetch).to eq(project_languages_info)
      end
    end
  end

  describe "Create" do
    it "should create a new language for the project" do
      params = {language_code: "fr", coordinators: ["wirido"]}

      VCR.use_cassette "project/components/create_language" do
        expect(project.languages.create(params)).to eq("Created")

        project.language("fr").delete
      end
    end

    it "should raise an error if the coordinator doesn't exist" do
      params = {language_code: "fr", coordinators: ["non_existing"]}

      VCR.use_cassette "project/components/create_language_non_existing_coordinator" do
        expect { project.languages.create(params) }.to raise_error(Transifex::TransifexError)
          .with_message("Users non_existing do not exist.")
      end
    end

    it "should raise an error if no coordinator is provided" do
      params = {language_code: "fr", coordinators: []}

      VCR.use_cassette "project/components/create_language_without_coordinator" do
        expect { project.languages.create(params) }.to raise_error(Transifex::TransifexError)
          .with_message("There must be a coordinator set for a language.")
      end
    end
  end
end
