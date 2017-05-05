require "spec_helper"

describe Transifex::ProjectComponents::LanguageComponents::Reviewers do
  let(:project) { Transifex::Project.new("ruby-client") }

  describe "Instantiation" do
    it "should raise an error if the project_slug is not provided" do
      expect{ Transifex::ProjectComponents::LanguageComponents::Reviewers.new }
        .to raise_error(Transifex::MissingParametersError)
        .with_message("The following attributes are missing: project_slug")
    end
  end

  describe "Fetch" do
    it "retrieves the language reviewers" do
      VCR.use_cassette "project/language/fetch_reviewers" do
        expect(project.language("en").reviewers.fetch).to eq({"reviewers" => ["wirido"]})
      end
    end
  end

  describe "Update" do
    it "updates the reviewers list" do
      VCR.use_cassette "project/language/update_reviewers" do
        expect(project.language("en").reviewers.update(["mupo"])).to eq("OK")
        expect(project.language("en").reviewers.fetch).to eq({"reviewers" => ["mupo"]})
      end
    end

    it "should raise an error if the reviewer doesn't exist" do
      VCR.use_cassette "project/language/update_non_existing_reviewer" do
        expect { project.language("en").reviewers.update(['not_existing_reviewer'])}
          .to raise_error(Transifex::TransifexError)
          .with_message("Users not_existing_reviewer do not exist.")
      end
    end
  end
end
