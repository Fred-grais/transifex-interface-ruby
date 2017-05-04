require "spec_helper"

describe Transifex::ProjectComponents::Language do
  let(:project) { Transifex::Project.new("ruby-client") }

  describe "Instantiation" do
    it "should raise an error if the project_slug is not provided" do
      expect { Transifex::ProjectComponents::Language.new }.to raise_error(Transifex::MissingParametersError)
        .with_message("The following attributes are missing: project_slug")
    end
  end

  describe "Fetch" do
    describe "#fetch" do
      it "should retrieve the basic info for the language" do
        VCR.use_cassette "project/language/fetch_language_info" do
          expect(project.language("en").fetch).to eq(basic_language_info)
        end
      end
    end

    describe "#fetch_with_details" do
      it "retrieve the complete info for the language" do
        VCR.use_cassette "project/language/fetch_with_details_language_info" do
          expect(project.language("en").fetch_with_details).to eq(detailed_language_info)
        end
      end
    end
  end

  describe "Update" do
    it "should raise an error if the language doesn't exist" do
      params = {coordinators: []}

      VCR.use_cassette "project/language/update_non_existing_language" do
        expect { project.language("non_existing_language").update(params) }.to raise_error(Transifex::TransifexError)
          .with_message("Not Found")
      end
    end

    it "should update the language info" do
      params = {"coordinators" => ["nirnaeth"], "translators" => [], "reviewers" => ["wirido"]}

      VCR.use_cassette "project/language/update_language" do
        expect(project.language("en").update(params)).to eq "OK"
        expect(project.language("en").fetch).to eq params
      end
    end
  end

  describe "Delete" do
    it "should delete the language" do
      VCR.use_cassette "project/language/delete_language" do
        project.languages.create(language_code: "it", coordinators: ["wirido"])

        expect(project.language("it").delete).to be nil
        expect { project.language("it").fetch }.to raise_error(Transifex::TransifexError)
          .with_message("Forbidden")
      end
    end
  end
end
