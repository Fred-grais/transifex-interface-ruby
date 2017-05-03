require "spec_helper"

describe Transifex::Project do
  describe "Manage a project" do
    let(:project) { Transifex::Project.new("private-ruby-client") }

    describe "Instanciation" do
      it "should raise an error if a slug is not provided" do
        expect { Transifex::Project.new }.to raise_error(Transifex::MissingParametersError)
          .with_message("The following attributes are missing: You must provide a slug for a project")
      end
    end

    describe "Fetch" do
      describe "#fetch" do
        it "should retrieve the basic info about the project" do
          VCR.use_cassette "project/fetch_private_project_info" do
            expect(project.fetch).to eq(private_project_info)
          end
        end
      end

      describe "#fetch_with_details" do
        it "should retrieve the complete info about the project" do
          VCR.use_cassette "project/fetch_with_details_private_project_info" do
            expect(project.fetch_with_details).to eq(detailed_private_project_info)
          end
        end
      end
    end

    describe "Update" do
      it "updates the project info" do
        VCR.use_cassette "project/update_private_project" do
          expect(project.update(description: "my new description")).to eq("OK")
          expect(project.fetch_with_details).to include({"description" => "my new description"})
        end
      end

      it "should raise an error if the field to be updated is not allowed" do
        VCR.use_cassette "project/update_non_existing_attribute_private_project" do
          expect(project.update({non_existing_attribute: "blah"})).to raise_error(Transifex::TransifexError)
            .with_message("Field 'non_existing_attribute' is not allowed.")
        end
      end

      it "should raise an error if no paramaters to update are provided" do
        VCR.use_cassette "project/update_with_missing_params_private_project" do
          expect { project.update }.to raise_error(Transifex::Error)
            .with_message("Empty request")
        end
      end
    end

    describe "Delete" do
      it "should delete the project" do
        VCR.use_cassette "project/delete_project" do
          expect(project.delete).to be nil
          expect { project.fetch }.to raise_error(Transifex::TransifexError).with_message("Not Found")
        end
      end
    end
  end
end
