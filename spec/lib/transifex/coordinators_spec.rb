require "spec_helper"

describe Transifex::ProjectComponents::LanguageComponents::Coordinators do
  let(:project) { Transifex::Project.new("ruby-client") }

  describe "Instantiation" do
    it "should raise an error if the project_slug is not provided" do
      expect { Transifex::ProjectComponents::LanguageComponents::Coordinators.new }
        .to raise_error(Transifex::MissingParametersError)
        .with_message("The following attributes are missing: project_slug")
    end
  end

  describe "Fetch" do
    it "should retrieve the language coordinators" do
      VCR.use_cassette "project/language/fetch_coordinators" do
        expect(project.language("en").coordinators.fetch).to eq({"coordinators"=>["wirido"]})
      end
    end
  end

  describe "Update" do
    it "overwrites the coordinators list" do
      VCR.use_cassette "project/language/update_coordinators" do
        expect(project.language("en").coordinators.update(["nirnaeth"])).to eq "OK"
        expect(project.language("en").coordinators.fetch).to eq({"coordinators"=>["nirnaeth"]})
      end
    end

    it "should raise an error if the coordinator doesn't exist" do
      VCR.use_cassette "project/language/update_non_existing_coordinator" do
        expect { project.language("en").coordinators.update(["not_existing_coordinator"]) }
          .to raise_error(Transifex::TransifexError)
          .with_message("Users not_existing_coordinator do not exist.")
      end
    end
  end
end
